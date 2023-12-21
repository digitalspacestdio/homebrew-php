#!/bin/bash
set -x
cd $(brew tap-info --json digitalspacestdio/php | jq -r '.[].path')/bin
while read line; do
    echo ./_php-bottles-make $line && ./_php-bottles-upload $line || echo "Failed to create bottles for $line"
done < <(brew search digitalspacestdio/php | grep 'php[0-9]\{2\}$' | awk -F'/' '{ print $3"" }' | sort)