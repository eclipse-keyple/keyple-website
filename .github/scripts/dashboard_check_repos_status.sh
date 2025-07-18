#!/bin/sh

# This script check all repositories until an update has been found.
# return 0 if at least one update was made, 1 if no.

token=$1

./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-card-calypso-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-card-calypso-crypto-legacysam-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-card-calypso-crypto-pki-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-card-generic-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-common-java-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-distributed-local-java-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-distributed-local-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-distributed-network-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-distributed-remote-java-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-distributed-remote-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-integration-java-test
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-java-example
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-plugin-android-nfc-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-plugin-android-omapi-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-plugin-java-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-plugin-pcsc-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-plugin-stub-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-plugin-cardresource-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-service-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-service-resource-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-util-java-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-plugin-storagecard-java-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-common-cpp-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-util-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-service-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-service-resource-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-plugin-cpp-api
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-plugin-stub-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-plugin-pcsc-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-card-generic-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-card-calypso-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-card-calypso-crypto-legacysam-cpp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-cpp-example
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-cpp-meta
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-interop-localreader-nfcmobile-kmp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-interop-jsonapi-client-kmp-lib
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-website
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-actions
if [ $? -eq 0 ]; then
  exit 0
fi
./.github/scripts/dashboard_check_repos_status_curl.sh $token eclipse-keyple keyple-api-docs
if [ $? -eq 0 ]; then
  exit 0
fi

exit 1