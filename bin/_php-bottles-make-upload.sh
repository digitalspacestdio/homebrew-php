#!/bin/bash
set -x
pushd `dirname $0` > /dev/null;DIR=`pwd -P`;popd > /dev/null
cd "${DIR}"

if [[ -z $1 ]]; then
    brew search digitalspacestdio/php | grep 'php[7-9]\{1\}[0-9]\{1\}$' | awk -F'/' '{ print $3"" }' | sort | while read line; do
        ./_php-bottles-make.sh $line && {
            ./_php-bottles-upload.sh $line || echo "Failed to upload bottles for $line"
        } || echo "Failed to build bottles for $line"
    done
else
    ./_php-bottles-make.sh $1 && ./_php-bottles-upload.sh $1 || echo "Failed to create bottles for $1"
fi