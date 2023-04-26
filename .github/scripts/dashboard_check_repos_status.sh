#!/bin/sh

# This script check all repositories until an update has been found.
# return 0 if at least one update was made, 1 if no.

token=$1

./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-card-calypso-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-card-calypso-crypto-legacysam-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-card-generic-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-common-java-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-distributed-local-java-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-distributed-local-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-distributed-network-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-distributed-remote-java-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-distributed-remote-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-integration-java-test
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-java-example
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-plugin-android-nfc-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-plugin-android-omapi-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-plugin-java-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-plugin-pcsc-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-plugin-stub-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-plugin-cardresource-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-service-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-service-resource-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-util-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-common-cpp-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-util-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-service-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-service-resource-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-plugin-cpp-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-plugin-stub-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-plugin-pcsc-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-card-generic-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-card-calypso-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-cpp-example
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-cpp-meta
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token keyple-website
if [ $? -eq 0 ]; then
  exit 0
fi

exit 1