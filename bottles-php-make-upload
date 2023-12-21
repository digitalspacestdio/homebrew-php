#!/bin/bash
set -x
cd $(brew tap-info --json digitalspacestdio/php | jq -r '.[].path')
while read line; do
    echo ./bottles-make.sh $line && ./bottles-upload.sh $line || echo "Failed to create bottles for $line"
done < <(brew search digitalspacestdio/php | grep 'php[0-9]\{2\}$' | awk -F'/' '{ print $3"" }' | sort)