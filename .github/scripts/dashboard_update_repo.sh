#!/bin/sh

token=$1
repository_name=$2
branch_name=$3
doc_flag=$4
ci_status_flag=$5

echo "Update the dashboard data of repository $repository_name..."

echo -n "[\"$repository_name\","$doc_flag","$ci_status_flag"]" >> dashboard/repository_list.json

../.github/scripts/dashboard_update_repo_curl.sh $token $repository_name "" ""
../.github/scripts/dashboard_update_repo_curl.sh $token $repository_name "/branches" "branches"
../.github/scripts/dashboard_update_repo_curl.sh $token $repository_name "/issues" "issues"
../.github/scripts/dashboard_update_repo_curl.sh $token $repository_name "/pulls" "pulls"
../.github/scripts/dashboard_update_repo_curl.sh $token $repository_name "/releases/latest" "releases_latest"
../.github/scripts/dashboard_update_repo_curl.sh $token $repository_name "/tags" "tags"
../.github/scripts/dashboard_update_repo_curl.sh $token $repository_name "/commits/"$branch_name"/status" "commits_status"
