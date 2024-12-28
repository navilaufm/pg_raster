#!/bin/bash

echo $0
cd "$(dirname "$0")"
echo "INICIO $(date -u +'%a %d %b %Y %I:%M:%S %p %Z')"

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
    ::: 'https://m.meteo.tech/w/' \
    ::: tif \
    ::: 'AFWA_CLOUD*' 'AFWA_PWAT*' 'AFWA_TOTPRECIP*' 'CLDFRA*' 'REFD_MAX*' 'T2*' 'TSK*' 'WDIR10*' 'WSPD10*' 'WSPD10MAX*' 'VIS*' 'HR2*' 'RAINC*' 'RAINNC*' 'RAINP*' 'RAINTOT*' \
    ::: /root/projects/pg_raster/down \
    ::: CLOUD PWAT TOTPRECIP CLDFRA REFDMAX T2 TSK WDIR10 WSPD10 WSPD10MAX VIS HR2 RAINC RAINNC RAINP RAINTOT

echo "FIN $(date -u +'%a %d %b %Y %I:%M:%S %p %Z')"