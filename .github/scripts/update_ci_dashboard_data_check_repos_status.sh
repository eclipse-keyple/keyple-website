#!/bin/sh

# This script checks if the target repository has been updated since the last check.
# returns 0 if true, 1 if false.

token=$1
repository_name=$2

echo "Checking repository "$repository_name"..."

# Compare hash value of the API result by excluding these fields:
# - "pushed_at": Cyclic commit when gh-pages branch is update.
# - "size": Unknown reason of size changing.
# - "admin", "maintain", "push", "triage", "pull", "...": Access rights to the keyple-website repo differ when owner is eclipse.

github_hash=`curl --request GET \
          --url https://api.github.com/repos/eclipse/$repository_name \
          --header "authorization: Bearer $token" \
          --header "content-type: application/json" | grep -v -e "pushed_at" -e "size" -e "\"admin\":" -e "maintain" -e "push" -e "triage" -e "pull" -e "allow_squash_merge" -e "allow_merge_commit" -e "allow_rebase_merge" -e "allow_auto_merge" -e "delete_branch_on_merge" -e "allow_update_branch" | md5sum | cut -d ' ' -f 1`

dashboard_hash=`curl --request GET \
          --url https://keyple.org/dashboard/$repository_name"_.json" \
          --header "content-type: application/json" | grep -v -e "pushed_at" -e "size" -e "\"admin\":" -e "maintain" -e "push" -e "triage" -e "pull" -e "allow_squash_merge" -e "allow_merge_commit" -e "allow_rebase_merge" -e "allow_auto_merge" -e "delete_branch_on_merge" -e "allow_update_branch" | md5sum | cut -d ' ' -f 1`

echo "github_hash="$github_hash
echo "dashboard_hash="$dashboard_hash

if [ "$github_hash" = "$dashboard_hash" ]; then
  echo "No update required"
  exit 1
else
  echo "Update required"
  echo "github value="`curl --request GET \
          --url https://api.github.com/repos/eclipse/$repository_name \
          --header "authorization: Bearer $token" \
          --header "content-type: application/json"`
  echo "dashboard value="`curl --request GET \
          --url https://keyple.org/dashboard/$repository_name"_.json" \
          --header "content-type: application/json"`
  exit 0
fi