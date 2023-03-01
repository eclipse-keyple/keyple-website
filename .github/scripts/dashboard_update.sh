#!/bin/sh

echo "Update the project dashboard content if needed..."

repository_owner=$1
repository_name="keyple-website"
token=$2

echo "Check if the dashboard needs to be updated..."
./.github/scripts/dashboard_check_repos_status.sh $token
if [ $? -eq 1 ]; then
  echo "No update is needed"
  exit 1
else
  echo "The dashboard needs to be updated because at least one repository has been updated"
fi

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
  echo "Error while checkout branch gh-pages"
  exit 1
fi

echo "Delete existing dashboard data directory..."
rm -rf dashboard/

../.github/scripts/dashboard_update_repos.sh $token

echo "Local dashboard data update finished."