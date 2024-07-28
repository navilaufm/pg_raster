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

# Check if any files match the pattern
if [ -z "$files" ]; then
  echo "No files found matching the pattern: $pattern.  Exiting..."
  exit 0
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
  fecha=$(echo "$filename" | cut -d'_' -f2 | sed 's/\([0-9][0-9]\)\([0-9][0-9]\)\([0-9][0-9]\)/\1-\2-\3/')
  hora=$(echo "$filename" | cut -d'_' -f3 | cut -c1-2)
  date_formatted="$fecha $hora"
  
 

  # Check if filename matches the pattern
  if [[ "$filename" == $pattern ]]; then
    wget -q "$url$file" -P "$download_dir"
    echo "Downloaded: $download_dir/$filename  Variable: $variable Fecha: $fecha Hora: $hora"

    # Export the password to avoid password prompt
    export PGPASSWORD="$dbpassword"

# Insert the raster into the database with additional columns
##set -x
raster2pgsql -s 4326 -a "$download_dir/$filename" raster_data | psql -h "$dbhost" -U "$dbuser" -d "$dbname" -p "$dbport"

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
