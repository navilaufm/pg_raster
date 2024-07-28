#!/bin/bash

# Check for required arguments
if [ $# -ne 3 ]; then
  echo "Usage: $0 <url> <extension> <download_dir>"
  exit 1
fi

# Assign arguments to variables
url="$1"
pattern="$2"
download_dir="$3"

# Create download directory if it doesn't exist
mkdir -p "$download_dir"

# Fetch HTML content
html=$(curl -s "$url")

# Extract file URLs matching the pattern
files=$(echo "$html" | grep -oE "href=\".*/$pattern\"" | cut -d'"' -f2)
echo $files
# Download each file
for file in $files; do
  curl -s "$url$file" -o "$download_dir/$file"
done

echo "Download completed."
exit (0)
#####################

# Assign arguments to variables
url="$1"
extension="$2"
download_dir="$3"

# Create download directory if it doesn't exist
mkdir -p "$download_dir"

# Fetch HTML content, extract TIF file URLs, and download each file
curl -s "$url" | grep -o 'href="[^"]*.'"$extension"'"' | sed 's/href="//' | sed 's/"$//' | xargs -I {} curl -O "$url"{}

# Move downloaded files to the specified directory
mv *."$extension" "$download_dir"

echo "Download completed."