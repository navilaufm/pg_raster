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

# Fetch HTML content
html=$(curl -s "$url")

# Extract file URLs matching the extension
files=$(echo "$html" | grep -o 'href="[^"]*'"$extension"'"' | sed 's/href="//' | sed 's/"$//')

# Download each file
for file in $files; do
  filename=$(basename "$file")
  
  # Check if filename matches the pattern
  if [[ "$filename" == $pattern ]]; then
    wget -q "$url$file" -P "$download_dir"
    echo "Downloaded: $download_dir/$filename"
  else
    echo "Skipping: $filename (does not match pattern)"
  fi
done

echo "Download completed."