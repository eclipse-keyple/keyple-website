#!/bin/sh

token=$1

echo "Create dashboard data directory..."
mkdir dashboard/

echo "{ \"datetime\":\"`date --utc --iso-8601=seconds`\"}" > dashboard/datetime.json

echo "[" >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-java-bom main false true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-card-calypso-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-card-calypso-crypto-legacysam-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-card-calypso-crypto-pki-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-card-generic-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-common-java-api main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-distributed-local-java-api main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-distributed-local-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-distributed-network-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-distributed-remote-java-api main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-distributed-remote-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-integration-java-test main false true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-java-example main false true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-plugin-android-nfc-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-plugin-android-omapi-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-plugin-java-api main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-plugin-pcsc-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-plugin-stub-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-plugin-cardresource-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-service-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-service-resource-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-util-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-plugin-storagecard-java-api main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-website master false false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-common-cpp-api master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-util-cpp-lib master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-service-cpp-lib master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-service-resource-cpp-lib master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-plugin-cpp-api master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-plugin-stub-cpp-lib master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-plugin-pcsc-cpp-lib master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-card-generic-cpp-lib master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-card-calypso-cpp-lib master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-card-calypso-crypto-legacysam-cpp-lib main true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-cpp-example master false false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-cpp-meta master false false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-interop-localreader-nfcmobile-kmp-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-interop-jsonapi-client-kmp-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-actions main false false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token eclipse-keyple keyple-api-docs main false false
echo "" >> dashboard/repository_list.json
echo "]" >> dashboard/repository_list.json