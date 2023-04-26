#!/bin/sh

token=$1

echo "Create dashboard data directory..."
mkdir dashboard/

echo "{ \"datetime\":\"`date --utc --iso-8601=seconds`\"}" > dashboard/datetime.json

echo "[" >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple master false false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-card-calypso-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-card-calypso-crypto-legacysam-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-card-generic-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-common-java-api main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-distributed-local-java-api main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-distributed-local-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-distributed-network-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-distributed-remote-java-api main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-distributed-remote-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-integration-java-test main false true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-java-example main false true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-plugin-android-nfc-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-plugin-android-omapi-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-plugin-java-api main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-plugin-pcsc-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-plugin-stub-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-plugin-cardresource-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-service-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-service-resource-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-util-java-lib main true true
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-website master false false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-common-cpp-api master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-util-cpp-lib master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-service-cpp-lib master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-service-resource-cpp-lib master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-plugin-cpp-api master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-plugin-stub-cpp-lib master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-plugin-pcsc-cpp-lib master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-card-generic-cpp-lib master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-card-calypso-cpp-lib master true false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-cpp-example master false false
echo "," >> dashboard/repository_list.json
../.github/scripts/dashboard_update_repo.sh $token keyple-cpp-meta master false false
echo "" >> dashboard/repository_list.json
echo "]" >> dashboard/repository_list.json