#!/bin/bash

# Check for required arguments
if [ $# -ne 3 ]; then
  echo "Usage: $0 <url> <pattern> <download_dir>"
  exit 1
fi

# Assign arguments to variables
url="$1"
pattern="$2"
download_dir="$3"

# Create download directory if it doesn't exist
mkdir -p "$download_dir"

# Fetch HTML content, extract URLs matching the pattern, and download each file
curl -s "$url" | grep -o 'href="[^"]*'"${pattern}"'"' | sed 's/href="//' | sed 's/"$//' | xargs -I {} curl -O "$url"{}

# Move downloaded files to the specified directory
mv $pattern "$download_dir"

echo "Download completed."
