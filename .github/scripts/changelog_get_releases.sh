#!/bin/bash

organization=$1
repository_name=$2
token=$3

# Module name (replace '-' with ' ')
temp="${2//-/ }"

# Capitalize the first letter of each word
module_name=""
for word in $temp; do
    capitalized_word="$(tr '[:lower:]' '[:upper:]' <<< "${word:0:1}")${word:1}"
    module_name+="$capitalized_word "
done

# Download and process JSON data with authentication
curl -s -S \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: Bearer $token" \
  "https://api.github.com/repos/$organization/$repository_name/releases?per_page=1000&page=1" | \
jq -c '.[] | tojson' | while read -r i; do
  i=$(echo "$i" | jq -r '.')
  tag_name=$(echo "$i" | jq -r '.tag_name')
  published_at=$(echo "$i" | jq -r '.published_at')
  body=$(echo "$i" | jq -r '.body' | sed 's/\\r\\n/\n/g')
  filename="$published_at.md"
  # Write the Markdown file contents
  echo "{{% changelog-element \"$(echo "$published_at" | cut -c 1-10)\" \"${module_name% }\" \"$tag_name\" %}} " > "$filename"
  echo -e "$body" >> "$filename"
  echo "{{% /changelog-element %}}" >> "$filename"
done
