#!/bin/bash
set -e
if [[ ! -z $DEBUG ]]; then set -x; fi
pushd `dirname $0` > /dev/null;DIR=`pwd -P`;popd > /dev/null
cd "${DIR}"

FORMULAS=${@:-$(brew search digitalspacestdio/php | grep 'php[7-9]\{1\}[0-9]\{1\}$' | awk -F'/' '{ print $3 }' | sort)}
echo $FORMULAS

for formula in $(brew search digitalspacestdio/php | grep 'php[7-9]\{1\}[0-9]\{1\}$' | awk -F'/' '{ print $3"" }' | sort); do
    echo "---> Starting $formula"
    ./_php-bottles-make.sh $formula && {
        ./_php-bottles-upload.sh $formula || echo "Failed to upload bottles for $formula"
    } || echo "Failed to build bottles for $formula"
    echo "---> Finished $formula"
done

# if [[ -z $1 ]]; then
#     for line in $(brew search digitalspacestdio/php | grep 'php[7-9]\{1\}[0-9]\{1\}$' | awk -F'/' '{ print $3"" }' | sort); do
#         ./_php-bottles-make.sh $line && {
#             ./_php-bottles-upload.sh $line || echo "Failed to upload bottles for $line"
#         } || echo "Failed to build bottles for $line"
#     done
# else
#     ./_php-bottles-make.sh $1 && ./_php-bottles-upload.sh $1 || echo "Failed to create bottles for $1"
# fi