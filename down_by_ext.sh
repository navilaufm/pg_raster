#!/bin/bash

# Check for required arguments
if [ $# -ne 5 ]; then
  echo "Usage: $0 <url> <extension> <pattern> <download_dir> <variable_name>"
  exit 1
fi

# Assign arguments to variables
url="$1"
extension="$2"
pattern="$3"
download_dir="$4"
variable="$5"

# Create download directory if it doesn't exist
mkdir -p "$download_dir"

# Fetch HTML content
html=$(curl -s "$url")

# Extract file URLs matching the extension
files=$(echo "$html" | grep -o 'href="[^"]*'"$extension"'"' | sed 's/href="//' | sed 's/"$//')

# If no files are found in HTML, try to fetch uploaded_files.txt
if [ -z "$files" ]; then
  temp_file="/tmp/uploaded_files_temp_$$.txt"
  curl -s "$url/uploaded_files.txt" -o "$temp_file" 2>/dev/null
  if [ -s "$temp_file" ]; then
    # Read filenames from uploaded_files.txt, extracting just the basename
    files=$(cat "$temp_file" | while read -r line; do basename "$line"; done)
    echo "Using file list from $url/uploaded_files.txt"
  else
    echo "Warning: No files found in HTML and uploaded_files.txt not available at $url"
  fi
  # Clean up temporary file
  rm -f "$temp_file"
fi

 #postgis 
    dbname="rasters"
    dbuser="rasters"
    dbport="11014"
    dbhost="localhost"
    dbpassword="rastersUniversal$%1"
    srid=4326

    # Export the password to avoid password prompt
    export PGPASSWORD="$dbpassword"
    ## delete older of same value
     psql -h "$dbhost" -U "$dbuser" -d "$dbname" -p "$dbport" -c "
      delete from raster_data where load_datetime<=now() and variable =   '$variable';
    "

# Download each file
for file in $files; do
  filename=$(basename "$file")
  
  ## ya no del nombre. :: variable=$(echo "$filename" | cut -d'_' -f1)
  ##fecha=$(echo "$filename" | cut -d'_' -f2 | sed 's/\([0-9][0-9]\)\([0-9][0-9]\)\([0-9][0-9]\)/\1-\2-\3/')
  ##hora=$(echo "$filename" | cut -d'_' -f3 | cut -c1-2)
  
  # Para obtener YYMMDD
  fecha=${filename: -13:6}
  fecha_formateada=$(echo $fecha | sed -r 's/(..)(..)(..)/\1-\2-\3/')


  # Para obtener HH
  hora=${filename: -6:2}
  
  date_formatted="$fecha_formateada $hora"
  
 

  # Check if filename matches the pattern
  if [[ "$filename" == $pattern ]]; then
    wget -q "$url$file" -P "$download_dir"
    echo "Downloaded: $download_dir/$filename  Variable: $variable Fecha: $fecha Hora: $hora"

    # Export the password to avoid password prompt
    export PGPASSWORD="$dbpassword"

# Insert the raster into the database with additional columns
##set -x
### check align raster2pgsql -s 4326 -a "$download_dir/$filename" raster_data | psql -h "$dbhost" -U "$dbuser" -d "$dbname" -p "$dbport"
raster2pgsql -s 4326 -C -a "$download_dir/$filename" raster_data | psql -h "$dbhost" -U "$dbuser" -d "$dbname" -p "$dbport"



     ## Update additional columns
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
##set +x
    
  else
    echo "."
  fi
done

echo "Download completed."
