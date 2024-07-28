#!/bin/bash

download_dir="./down"
database_name="rasters"
srid=4326
url="https://cc1.meteo.tech/data/icon/"
file_pattern="temp_*.tif"  # Replace with desired pattern

mkdir -p "$download_dir"

html=$(curl "$url")

files=$(echo "$html" | grep -oE "href=\"/$file_pattern\"" | cut -d'/' -f4)

for file in $files; do
    download_url="$url$file"
    local_file="$download_dir/$file"

    wget "$download_url" -O "$local_file"

    # Your raster2pgsql command here
    # ...
done
