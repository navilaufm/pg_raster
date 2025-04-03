#!/bin/bash

# Check for required arguments
if [ $# -ne 5 ]; then
  echo "Usage: $0 <url_or_folder> <extension> <pattern> <download_dir> <variable_name>"
  exit 1
fi

# Assign arguments to variables
source="$1"
extension="$2"
pattern="$3"
download_dir="$4"
variable="$5"

# Create download directory if it doesn't exist
mkdir -p "$download_dir"

# Function to check if a string is a URL
is_url() {
  [[ "$1" =~ ^(http|https|ftp):// ]] && return 0 || return 1
}

# Determine source type and get list of files
if is_url "$source"; then
  html=$(curl -s "$source")
  files=$(echo "$html" | grep -o 'href="[^"]*'"$extension"'"' | sed 's/href="//' | sed 's/"$//')
  source_type="url"
else
  if [ ! -d "$source" ]; then
    echo "Local folder '$source' does not exist. Exiting..."
    exit 1
  fi
  files=$(ls "$source"/*."$extension" 2>/dev/null | xargs -n 1 basename)
  source_type="folder"
fi

if [ -z "$files" ]; then
  echo "No files found matching the extension: $extension. Exiting..."
  exit 0
fi

# PostGIS configuration
dbname="rasters"
dbuser="rasters"
dbport="11014"
dbhost="localhost"
dbpassword="rastersUniversal$%1"
srid=4326

# Export password for initial delete (single operation)
export PGPASSWORD="$dbpassword"
psql -h "$dbhost" -U "$dbuser" -d "$dbname" -p "$dbport" -c "
  DELETE FROM raster_data WHERE load_datetime <= now() AND variable = '$variable';
"
unset PGPASSWORD

# Function to process a single file
process_file() {
  local file="$1"
  local source_type="$2"
  local source="$3"
  local download_dir="$4"
  local variable="$5"
  local dbhost="$6"
  local dbuser="$7"
  local dbname="$8"
  local dbport="$9"
  local dbpassword="${10}"

  filename=$(basename "$file")
  fecha=${filename: -13:6}
  fecha_formateada=$(echo "$fecha" | sed -r 's/(..)(..)(..)/\1-\2-\3/')
  hora=${filename: -6:2}
  date_formatted="$fecha_formateada $hora"

  if [[ "$filename" == $pattern ]]; then
    if [ "$source_type" = "url" ]; then
      wget -q "$source$file" -P "$download_dir"
      echo "Downloaded: $download_dir/$filename  Variable: $variable Fecha: $fecha Hora: $hora"
      raster_file="$download_dir/$filename"
    else
      echo "Processing: $source/$filename  Variable: $variable Fecha: $fecha Hora: $hora"
      raster_file="$source/$filename"
    fi

    export PGPASSWORD="$dbpassword"
    raster2pgsql -s 4326 -C -a "$raster_file" raster_data | psql -h "$dbhost" -U "$dbuser" -d "$dbname" -p "$dbport" -q
    psql -h "$dbhost" -U "$dbuser" -d "$dbname" -p "$dbport" -q -c "
      UPDATE raster_data
      SET filename = '$filename',
          variable = '$variable',
          date = '$date_formatted'
      WHERE filename IS NULL;
    "
    unset PGPASSWORD
    echo "Insert completed for $filename"
  else
    echo "Skipping $filename (does not match pattern)"
  fi
}

# Export the function for parallel to use
export -f process_file

# Run file processing in parallel with 16 jobs
echo "$files" | parallel -j 16 process_file {} "$source_type" "$source" "$download_dir" "$variable" "$dbhost" "$dbuser" "$dbname" "$dbport" "$dbpassword"

echo "Processing completed."