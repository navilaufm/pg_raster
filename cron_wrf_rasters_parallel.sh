#!/bin/bash

# Define the base URL
base_url="https://m.meteo.tech/w/"

# Define the file extension
file_ext="tif"

# Define the output directory
output_dir="/root/projects/pg_raster/down"

# Define an array of file prefixes to download
file_prefixes=(
  "AFWA_CLOUD"
  "AFWA_PWAT"
  "AFWA_TOTPRECIP"
  "CLDFRA"
  "REFD_MAX"
  "T2"
  "TSK"
  "WDIR10"
  "WSPD10"
  "WSPD10MAX"
  "VIS"
  "HR2"
  "RAINC"
  "RAINNC"
  "RAINP"
  "RAINTOT"
)

# Use GNU parallel to download files concurrently
parallel --no-notice bash down_by_ext.sh {base_url} {file_ext} {} ${output_dir} ::: "${file_prefixes[@]}"

echo "All downloads finished!"