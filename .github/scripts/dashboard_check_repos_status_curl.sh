#!/bin/sh

# This script checks if the target repository has been updated since the last check.
# returns 0 if true, 1 if false.

token=$1
repository_name=$2

filter_website_repository=""

if [ "$repository_name" = "keyple-website" ]; then
  filter_website_repository=" -e \"pushed_at\""
fi

echo "Checking repository "$repository_name"..."

# Compare hash value of the API result by excluding these fields:
# - "size": Unknown reason of size changing.
# - "pushed_at": Cyclic commit when gh-pages branch is update (keyple-website).

github_json=`curl --request GET \
          --url https://api.github.com/repos/eclipse/$repository_name \
          --header "authorization: Bearer $token" \
          --header "content-type: application/json" | grep -v -e "size"$filter_website_repository`
github_hash=`echo $github_json | md5sum | cut -d ' ' -f 1`

dashboard_json=`curl --request GET \
          --url https://keyple.org/dashboard/$repository_name"_.json" \
          --header "content-type: application/json" | grep -v -e "size"$filter_website_repository`
dashboard_hash=`echo $dashboard_json | md5sum | cut -d ' ' -f 1`

if [ "$github_hash" = "$dashboard_hash" ]; then
  echo "No update required"
  exit 1
else
  echo "Update required"
  echo "################################################################################"
  echo "     Github JSON hash = "$github_hash
  echo "  Dashboard JSON hash = "$dashboard_hash
  echo "###################"
  echo "##  Github JSON  ##"
  echo "###################"
  echo $github_json
  echo "######################"
  echo "##  Dashboard JSON  ##"
  echo "######################"
  echo $dashboard_json
  echo "################################################################################"
  exit 0
fi