#!/bin/bash

REPOS_LIST="./.github/scripts/changelog_repos.list"
CHANGELOG_PAGE="./content/community/changelog/_index.md"


# Remove all .md files in the current directory
echo "Removing existing .md files..."
rm -f ./*.md

# Loop through each line in the changelog_repos.list file
while read -r repo; do
  if [ ! -z "$repo" ]; then
    echo "Processing repository: $repo"
    ./.github/scripts/changelog_get_releases.sh "$repo"
  fi
done < $REPOS_LIST

# Concatenate all .md files into a new changelog file, sorted in reverse alphabetical order by their names
echo "Concatenating .md files into changelog..."
touch changelog
for md_file in $(ls ./*.md | sort -r); do
  cat "$md_file" >> changelog
done

echo "Inserting changelog text into destination page..."
awk -v replacement="$(cat ./changelog)" '{gsub("<!-- CHANGELOG_CONTENT -->", replacement)}1' $CHANGELOG_PAGE > temp.md
mv temp.md $CHANGELOG_PAGE
