#!/bin/sh

echo "Checkout gh-pages..."

repository_owner=$1
repository_name="keyple-website"

echo "Clone $repository_name..."
git clone https://github.com/$repository_owner/$repository_name.git

if [ $? -ne 0 ]; then
  echo "Error while cloning repository "$repository_name
  exit 1
fi

cd $repository_name

echo "Checkout gh-pages branch..."
git checkout -f gh-pages

if [ $? -ne 0 ]; then
  echo "Error while checking out branch gh-pages"
  exit 1
fi

echo "Delete existing data directory..."
rm -f docs/statistics/*.csv
rm -f docs/statistics/repos_list

echo "Checkout complete and old CSV data deleted."
