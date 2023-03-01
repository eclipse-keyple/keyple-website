#!/bin/sh

echo "Initialize the project dashboard content..."

token=$1

../.github/scripts/dashboard_update_repos.sh $token

echo "Local dashboard data initialisation finished."