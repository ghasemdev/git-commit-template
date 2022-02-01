#!/bin/bash

# Check the current folder is a git repository
$(git -C $PWD rev-parse)
if [[ $? != 0 ]]; then
    exit 1
fi

# Color formatting
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[1;34m"
CYAN="\033[0;36m"
RESET="\033[0m"

REGEX_VERSION="^[0-9]*\.[0-9]*\.[0-9]*$"

# Version section
printf "${CYAN}>>> Version number (MAJOR.Minor.patch)?${RESET}\n"
while :; do
    read -e version
    # When input type is valid loop break
    if [[ $version =~ $REGEX_VERSION ]]; then
        break
    else
        printf "${RED}❌ Version format does not correct.${RESET}\n"
    fi
done

# Question section
COMMENT_FLAG=''

printf "\n${CYAN}>>> Do you want add comment for tag (y/n)? ${RESET}"
while true; do
    read -e yn
    case $yn in
    [Yy]*)
        COMMENT_FLAG='.'
        break
        ;;
    [Nn]*) break ;;
    esac
done

# Commit message section
header=""
massage=""
if [ ! -z "$COMMENT_FLAG" ]; then

    printf "\n${CYAN}>>> Write a short description about this tag.${RESET}\n"
    while :; do
        read -e input
        if [ -z "$input" ]; then
            printf "${RED}❌ Header can not be empty.${RESET}\n"
        else
            header="$input"
            break
        fi
    done

    printf "\n${CYAN}>>> What new 🚀 features have been added (optional)?${RESET}\n"
    read -e features
    if [ ! -z "$features" ]; then
        massage="
🚀 Features
    ${features}
"
    fi

    printf "\n${CYAN}>>> Which 🐛 bugs have been fixed (optional)?${RESET}\n"
    read -e fixes
    if [ ! -z "$fixes" ]; then
        massage="${massage}
🐛 Fixes
    ${fixes}
"
    fi

    printf "\n${CYAN}>>> What 🧪 tests have been added (optional)?${RESET}\n"
    read -e tests
    if [ ! -z "$tests" ]; then
        massage="${massage}
🧪 Tests
    ${tests}
"
    fi

    printf "\n${CYAN}>>> 💭 Other explanations you want to add (optional).${RESET}\n"
    read -e others
    if [ ! -z "$others" ]; then
        massage="${massage}
💭 Others
    ${others}
"
    fi
fi

printf "\n${GREEN}v${version} ${header}\n${massage}\n${RESET}"
massage="${header}

${massage}"

# Git tag
if [ $? == 0 ]; then
    if [[ $1 == "-s" ]] || [[ $1 == "sign" ]]; then
        if [ ! -z "$COMMENT_FLAG" ]; then
            git tag -s "v$version" -m "$massage"
        else
            git tag -s "v$version"
        fi
    else
        if [ ! -z "$COMMENT_FLAG" ]; then
            git tag "v$version" -m "$massage"
        else
            git tag "v$version"
        fi
    fi
else
    printf "\n${RED}❌ An error occurred. Please try again.${RESET}\n"
    exit 1
fi
