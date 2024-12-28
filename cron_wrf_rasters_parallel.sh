#!/bin/bash

echo $0
cd "$(dirname "$0")"
echo "INICIO $(date)"

# Function to download files (optional, but makes the script cleaner)
download_files() {
    local url=$1
    local ext=$2
    local pattern=$3
    local dest=$4
    local new_name=$5
    bash down_by_ext.sh "$url" "$ext" "$pattern" "$dest" "$new_name"
}

export -f download_files  # Export the function for parallel to use

# Use GNU parallel to download files in parallel
parallel download_files \
    'https://m.meteo.tech/w/' tif AFWA_CLOUD* /root/projects/pg_raster/down CLOUD \
    'https://m.meteo.tech/w/' tif AFWA_PWAT* /root/projects/pg_raster/down PWAT \
    'https://m.meteo.tech/w/' tif AFWA_TOTPRECIP* /root/projects/pg_raster/down TOTPRECIP \
    'https://m.meteo.tech/w/' tif CLDFRA* /root/projects/pg_raster/down CLDFRA \
    'https://m.meteo.tech/w/' tif REFD_MAX* /root/projects/pg_raster/down REFDMAX \
    'https://m.meteo.tech/w/' tif T2* /root/projects/pg_raster/down T2 \
    'https://m.meteo.tech/w/' tif TSK* /root/projects/pg_raster/down TSK \
    'https://m.meteo.tech/w/' tif WDIR10* /root/projects/pg_raster/down WDIR10 \
    'https://m.meteo.tech/w/' tif WSPD10* /root/projects/pg_raster/down WSPD10 \
    'https://m.meteo.tech/w/' tif WSPD10MAX* /root/projects/pg_raster/down WSPD10MAX \
    'https://m.meteo.tech/w/' tif VIS* /root/projects/pg_raster/down VIS \
    'https://m.meteo.tech/w/' tif HR2* /root/projects/pg_raster/down HR2 \
    'https://m.meteo.tech/w/' tif RAINC* /root/projects/pg_raster/down RAINC \
    'https://m.meteo.tech/w/' tif RAINNC* /root/projects/pg_raster/down RAINNC \
    'https://m.meteo.tech/w/' tif RAINP* /root/projects/pg_raster/down RAINP \
    'https://m.meteo.tech/w/' tif RAINTOT* /root/projects/pg_raster/down RAINTOT

echo "FIN $(date)"