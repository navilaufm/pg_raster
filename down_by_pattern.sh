#!/bin/bash

# Check for required arguments
if [ $# -ne 4 ]; then
  echo "Usage: $0 <url> <extension> <pattern> <download_dir>"
  exit 1
fi

# Assign arguments to variables
url="$1"
extension="$2"
pattern="$3"
download_dir="$4"

# Create download directory if it doesn't exist
mkdir -p "$download_dir"

# Fetch HTML content, extract URLs matching the pattern, and download each file
curl -s "$url" | grep -o 'href="[^"]*'"$pattern"'.'"$extension"'"' | sed 's/href="//' | sed 's/"$//' | xargs -I {} curl -O "$url"{}

# Move downloaded files to the specified directory
mv "$pattern"."$extension" "$download_dir"

echo "Download completed."
