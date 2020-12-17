#!/bin/bash

function select_option {

    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "   $1 "; }
    print_selected()   { printf "  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n3 key 2>/dev/null >&2
                         if [[ $key = "${ESC}[A" ]]; then echo up;    fi
                         if [[ $key = "${ESC}[B" ]]; then echo down;  fi
                         if [[ $key = ""     ]]; then echo enter; fi; }

    # initially print empty new lines (scroll down if at bottom of screen)
    for opt; do printf "\n"; done

    # determine current screen position for overwriting the options
    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - $#))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local selected=${DEFAULT_SELECT_OPTION:-0}
    while true; do
        # print options by overwriting the last lines
        local idx=0
        for opt; do
            cursor_to $(($startrow + $idx))
            if [ $idx -eq $selected ]; then
                print_selected "$opt"
            else
                print_option "$opt"
            fi
            ((idx++))
        done

        # user key control
        case `key_input` in
            enter) break;;
            up)    ((selected--));
                   if [ $selected -lt 0 ]; then selected=$(($# - 1)); fi;;
            down)  ((selected++));
                   if [ $selected -ge $# ]; then selected=0; fi;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    return $selected
}

function get_javadoc() {
  local VERSION=$2
  local BASE_PATH="$(dirname "$0")"

  # get the lastest published SNAPSHOT timestamp for this version
  VERSION_TIMESTAMP=$(wget -O - -o /dev/null $BASE_URL/$1/$VERSION/maven-metadata.xml | grep -oPm1 "(?<=<timestamp>)[^<]+")

  # get the lastest published SNAPSHOT buildNumber for this version
  VERSION_BUILD_NUMBER=$(wget -O - -o /dev/null $BASE_URL/$1/$VERSION/maven-metadata.xml | grep -oPm1 "(?<=<buildNumber>)[^<]+")

  # get the version (remove -SNAPSHOT)
  VERSION=$(echo $VERSION | sed -e "s/-SNAPSHOT$//")

  # get the Javadoc jar
  mkdir -p "${BASE_PATH}/tmp"
  wget "${BASE_PATH}/tmp/${BASE_URL}/${1}/${VERSION}/${1}-${VERSION}-javadoc.jar"

  mkdir -p "${BASE_PATH}/static/docs/api-reference/java-api/${1}/${VERSION}"
  unzip "${BASE_PATH}/tmp/${1}-${VERSION}-javadoc.jar" -d "${BASE_PATH}/static/docs/api-reference/java-api/${1}/${VERSION}"
}

BASE_URL="https://repo1.maven.org/maven2/org/eclipse/keyple"
options=($(wget -O - -o /dev/null $BASE_URL/keyple-java-core/maven-metadata.xml | grep -Po '(?<=<version>)([0-9alph\.-]+(-SNAPSHOT)?)' | sort --version-sort -r))
select_option "${options[@]}"
VERSION=${options[$?]}

get_javadoc keyple-java-core ${VERSION}
get_javadoc keyple-java-calypso ${VERSION}
get_javadoc keyple-java-plugin-pcsc ${VERSION}
get_javadoc keyple-java-distributed-local ${VERSION}
get_javadoc keyple-java-distributed-network ${VERSION}
get_javadoc keyple-java-distributed-remote ${VERSION}
get_javadoc keyple-java-plugin-stub ${VERSION}
get_javadoc keyple-android-plugin-nfc ${VERSION}
get_javadoc keyple-android-plugin-omapi ${VERSION}


cat > "./static/docs/api-reference/java-api/list-${VERSION}.json" <<- EOF
{
  "keyple-java-core": "Keyple Core API",
  "keyple-java-calypso": "Keyple Calypso API",
  "keyple-java-plugin-pcsc": "Keyple PC/SC plugin API",
  "keyple-java-distributed-local": "Keyple Distributed Local API",
  "keyple-java-distributed-network": "Keyple Distributed Network API",
  "keyple-java-distributed-remote": "Keyple Distributed Remote API",
  "keyple-java-plugin-stub": "Keyple Stub plugin API",
  "keyple-android-plugin-nfc": "Keyple Android NFC plugin API",
  "keyple-android-plugin-omapi": "Keyple Android OMAPI plugin API"
}
EOF

(
  cd $(dirname "$0")/static/docs/api-reference/java-api
  for component in *; do
    [ ! -d "${component}" ] && break;
    (
      cd "${component}"
      echo "[" > "versions.json"
      for version in *; do
        [ ! -d "${version}" ] && break;
        echo "  \"${version}\"," >> "versions.json"
      done
      echo -e "  \"latest\"\n]" >> "versions.json"
    )  
  done
)
