#!/bin/sh

# This script checks if the target repository has been updated since the last check.
# returns 0 if true, 1 if false.

token=$1
repository_name=$2

echo "Checking repository "$repository_name"..."

last_update_date=`curl --request GET \
          --url https://api.github.com/repos/eclipse/$repository_name \
          --header "authorization: Bearer $token" \
          --header "content-type: application/json" | grep updated_at`

current_update_date=`curl --request GET \
          --url https://keyple.org/dashboard/$repository_name"_.json" \
          --header "content-type: application/json" | grep updated_at`

echo "last_update_date="$last_update_date
echo "current_update_date="$current_update_date

if [ "$last_update_date" = "$current_update_date" ]; then
  echo "No update required"
  exit 1
else
  echo "Update required"
  exit 0
fi