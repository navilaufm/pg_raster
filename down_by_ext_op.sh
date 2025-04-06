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

# Create download directory if it doesn't exist (only needed for URL mode)
mkdir -p "$download_dir"

# Function to check if a string is a URL
is_url() {
  [[ "$1" =~ ^(http|https|ftp):// ]] && return 0 || return 1
}

# Determine if source is a URL or local folder and get list of files
if is_url "$source"; then
  # Fetch HTML content for URL
  html=$(curl -s "$source")
  # Extract file URLs matching the extension
  files=$(echo "$html" | grep -o 'href="[^"]*'"$extension"'"' | sed 's/href="//' | sed 's/"$//')
  source_type="url"
else
  # Check if local folder exists
  if [ ! -d "$source" ]; then
    echo "Local folder '$source' does not exist. Exiting..."
    exit 1
  fi
  # Get files from local folder matching the extension
  files=$(ls "$source"/*."$extension" 2>/dev/null | xargs -n 1 basename)
  source_type="folder"
fi

# Check if any files match the pattern
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

# Export the password to avoid password prompt
export PGPASSWORD="$dbpassword"
# Delete older records of same variable
psql -h "$dbhost" -U "$dbuser" -d "$dbname" -p "$dbport" -c "
  DELETE FROM raster_data WHERE load_datetime <= now() AND variable = '$variable';
"

# Process each file
for file in $files; do
  filename=$(basename "$file")

  # Extract date and time from filename
  fecha=${filename: -13:6}
  fecha_formateada=$(echo "$fecha" | sed -r 's/(..)(..)(..)/\1-\2-\3/')
  hora=${filename: -6:2}
  date_formatted="$fecha_formateada $hora"

  # Check if filename matches the pattern
  if [[ "$filename" == $pattern ]]; then
    # Handle URL or local folder
    if [ "$source_type" = "url" ]; then
      # Download file from URL to download_dir
      wget -q "$source$file" -P "$download_dir"
      echo "Downloaded: $download_dir/$filename  Variable: $variable Fecha: $fecha Hora: $hora"
      raster_file="$download_dir/$filename"
    else
      # Use file directly from local folder
      echo "Processing: $source/$filename  Variable: $variable Fecha: $fecha Hora: $hora"
      raster_file="$source/$filename"
    fi

    # Export the password to avoid password prompt
    export PGPASSWORD="$dbpassword"

    # Insert the raster into the database
    raster2pgsql -s 4326 -C -a "$raster_file" raster_data | psql -h "$dbhost" -U "$dbuser" -d "$dbname" -p "$dbport"

    # Update additional columns
    psql -h "$dbhost" -U "$dbuser" -d "$dbname" -p "$dbport" -c "
      UPDATE raster_data
      SET filename = '$filename',
          variable = '$variable',
          date = '$date_formatted'
      WHERE filename IS NULL;
    "

    # Unset the password environment variable for security
    unset PGPASSWORD

    echo "Insert completed."
  else
    echo "."
  fi
done

echo "Processing completed."