#!/bin/bash

# This script gets the latest javadoc JAR (SNAPSHOT) for the module provided in argument (e.g. keyple-java-core)

# get the lastest SNAPSHOT version, put it in a variable named LATEST_SNAPSHOT_VERSION
BASE_URL="https://oss.sonatype.org/content/repositories/snapshots/org/eclipse/keyple"
LATEST_SNAPSHOT=$(wget -O - -o /dev/null $BASE_URL/$1/maven-metadata.xml | grep -Po '(?<=<version>)([0-9\.]+(-SNAPSHOT)?)' | sort --version-sort -r | head -n 1)

# get the lastest published SNAPSHOT timestamp for this version
LATEST_SNAPSHOT_TIMESTAMP=$(wget -O - -o /dev/null $BASE_URL/$1/$LATEST_SNAPSHOT/maven-metadata.xml | grep -oPm1 "(?<=<timestamp>)[^<]+")

# get the lastest published SNAPSHOT buildNumber for this version
LATEST_SNAPSHOT_BUILD_NUMBER=$(wget -O - -o /dev/null $BASE_URL/$1/$LATEST_SNAPSHOT/maven-metadata.xml | grep -oPm1 "(?<=<buildNumber>)[^<]+")

# get the version (remove -SNAPSHOT)
VERSION=$(echo $LATEST_SNAPSHOT | sed -e "s/-SNAPSHOT$//")

# get the Javadoc jar
wget $BASE_URL/$1/$LATEST_SNAPSHOT/$1"-"$VERSION"-"$LATEST_SNAPSHOT_TIMESTAMP"-"$LATEST_SNAPSHOT_BUILD_NUMBER"-javadoc.jar"

# unzip in destination folder (folder name = module name)
unzip ./$1"-"$VERSION"-"$LATEST_SNAPSHOT_TIMESTAMP"-"$LATEST_SNAPSHOT_BUILD_NUMBER"-javadoc.jar" -d ./public/reference/$1
