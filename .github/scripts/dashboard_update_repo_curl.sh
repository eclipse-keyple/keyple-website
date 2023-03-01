#!/bin/sh

token=$1
repository_name=$2
resource=$3
file_suffix=$4

curl --request GET \
          --url https://api.github.com/repos/eclipse/$repository_name$resource \
          --header "authorization: Bearer $token" \
          --header "content-type: application/json" > "dashboard/"$repository_name"_"$file_suffix".json"
