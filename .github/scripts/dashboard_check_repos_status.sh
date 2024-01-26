#!/bin/sh

# This script check all repositories until an update has been found.
# return 0 if at least one update was made, 1 if no.

token=$1

./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-card-calypso-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-card-calypso-crypto-legacysam-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-card-generic-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-common-java-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-distributed-local-java-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-distributed-local-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-distributed-network-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-distributed-remote-java-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-distributed-remote-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-integration-java-test
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-java-example
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-plugin-android-nfc-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-plugin-android-omapi-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-plugin-java-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-plugin-pcsc-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-plugin-stub-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-plugin-cardresource-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-service-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-service-resource-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-util-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-common-cpp-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-util-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-service-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-service-resource-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-plugin-cpp-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-plugin-stub-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-plugin-pcsc-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-card-generic-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-card-calypso-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-cpp-example
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-cpp-meta
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse keyple-website
if [ $? -eq 0 ]; then
  exit 0
fi

exit 1