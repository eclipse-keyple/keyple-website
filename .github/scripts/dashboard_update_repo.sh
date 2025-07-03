#!/bin/sh

token=$1
organization=$2
repository_name=$3
branch_name=$4
doc_flag=$5
ci_status_flag=$6

echo "Update the dashboard data of repository $repository_name..."

echo -n "[\"$repository_name\","$doc_flag","$ci_status_flag"]" >> dashboard/repository_list.json

../.github/scripts/dashboard_update_repo_curl.sh $token $organization $repository_name "" ""
../.github/scripts/dashboard_update_repo_curl.sh $token $organization $repository_name "/branches" "branches"
../.github/scripts/dashboard_update_repo_curl.sh $token $organization $repository_name "/issues" "issues"
../.github/scripts/dashboard_update_repo_curl.sh $token $organization $repository_name "/pulls" "pulls"
../.github/scripts/dashboard_update_repo_curl.sh $token $organization $repository_name "/releases/latest" "releases_latest"
../.github/scripts/dashboard_update_repo_curl.sh $token $organization $repository_name "/tags" "tags"
../.github/scripts/dashboard_update_repo_curl.sh $token $organization $repository_name "/commits/"$branch_name"/check-runs" "check_runs"
