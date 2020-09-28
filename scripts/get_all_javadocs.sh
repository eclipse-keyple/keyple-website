#!/bin/bash

# This script gets all latest javadocs (SNAPSHOT)
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bash ${__dir}/get_javadoc.sh keyple-java-core
bash ${__dir}/get_javadoc.sh keyple-java-calypso
bash ${__dir}/get_javadoc.sh keyple-java-plugin-pcsc
bash ${__dir}/get_javadoc.sh keyple-java-plugin-remotese
bash ${__dir}/get_javadoc.sh keyple-java-plugin-stub
bash ${__dir}/get_javadoc.sh keyple-java-plugin-remotese
bash ${__dir}/get_javadoc.sh keyple-android-plugin-nfc
bash ${__dir}/get_javadoc.sh keyple-android-plugin-omapi

