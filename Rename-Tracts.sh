#!/bin/bash

# Navigate to the tracts directory
cd /shared/ministry/gospel-tracts/tracts || exit

# Function to convert names to lowercase with dashes
convert_name() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | sed -E 's/[ _]+/-/g'
}

# Rename directories and files
find . -depth | while read -r path; do
    # Skip README.md
    if [[ "$(basename "$path")" == "README.md" ]]; then
        continue
    fi

    # Get the directory and base name
    dir=$(dirname "$path")
    base=$(basename "$path")

    # Convert the name
    new_base=$(convert_name "$base")

    # Rename if the name has changed
    if [[ "$base" != "$new_base" ]]; then
        mv "$path" "$dir/$new_base"
    fi
done
