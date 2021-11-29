#!/bin/sh

# This script checks if the target repository has been updated since the last check.
# returns 0 if true, 1 if false.

token=$1
repository_name=$2

echo "Checking repository "$repository_name"..."

github_hash=`curl --request GET \
          --url https://api.github.com/repos/eclipse/$repository_name \
          --header "authorization: Bearer $token" \
          --header "content-type: application/json" | grep -v -e "pushed_at" -e "size" | md5sum | cut -d ' ' -f 1`

dashboard_hash=`curl --request GET \
          --url https://keyple.org/dashboard/$repository_name"_.json" \
          --header "content-type: application/json" | grep -v -e "pushed_at" -e "size" | md5sum | cut -d ' ' -f 1`

echo "github_hash="$github_hash
echo "dashboard_hash="$dashboard_hash

if [ "$github_hash" = "$dashboard_hash" ]; then
  echo "No update required"
  exit 1
else
  echo "Update required"
  exit 0
fi