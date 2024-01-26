#!/bin/sh

token=$1
organization=$2
repository_name=$3
resource=$4
file_suffix=$5

curl --request GET \
          --url https://api.github.com/repos/$organization/$repository_name$resource \
          --header "authorization: Bearer $token" \
          --header "content-type: application/json" > "dashboard/"$repository_name"_"$file_suffix".json"
