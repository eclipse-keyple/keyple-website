#!/bin/bash

REPOS_LIST="./.github/scripts/changelog_repos.list"
CHANGELOG_PAGE="./content/community/changelog/_index.md"
TOKEN="${ORG_GITHUB_BOT_TOKEN:-$3}"

if [ -z "$TOKEN" ]; then
  echo "❌ ERROR: No GitHub token provided. Set ORG_GITHUB_BOT_TOKEN env or pass as 3rd argument."
  exit 1
fi

# Remove all .md files in the current directory
echo "Removing existing .md files..."
rm -f ./*.md

# Loop through each line in the changelog_repos.list file
while read -r line; do
  if [ ! -z "$line" ]; then
    organization=$(echo "$line" | cut -d ' ' -f1)
    repository=$(echo "$line" | cut -d ' ' -f2)
    echo "Processing repository: $organization $repository"
    ./.github/scripts/changelog_get_releases.sh "$organization" "$repository" "$TOKEN"
  fi
done < "$REPOS_LIST"

# Concatenate all .md files into a new changelog file, sorted in reverse alphabetical order by their names
echo "Concatenating .md files into changelog..."
touch changelog
for md_file in $(ls ./*.md 2>/dev/null | sort -r); do
  cat "$md_file" >> changelog
done

# Insert changelog into the destination page
echo "Inserting changelog text into destination page..."
awk -v replacement="$(cat ./changelog)" \
    '{gsub("<!-- CHANGELOG_CONTENT -->", replacement)}1' "$CHANGELOG_PAGE" > temp.md
mv temp.md "$CHANGELOG_PAGE"

cat "$CHANGELOG_PAGE"
