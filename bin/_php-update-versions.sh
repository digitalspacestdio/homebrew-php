#!/bin/bash
set -x
set -e
if [[ ! -z $DEBUG ]]; then set -x; fi
#pushd `dirname $0` > /dev/null;DIR=`pwd -P`;popd > /dev/null

brew tap digitalspacestdio/common
brew tap digitalspacestdio/php
cd $(brew tap-info --json digitalspacestdio/php | jq -r '.[].path')
#git stash
#git pull
DIR=$(pwd -P)
source $DIR/.vars

for VERSION in "5.6" "7.0" "7.1" "7.2" "7.3" "7.4" "8.0" "8.1" "8.2" "8.3", "8.4"
do
# RELEASES=$(curl -L --silent 'https://www.php.net/releases?json&version='$VERSION)
# PHP_VERSION=$(echo ${RELEASES} | jq -r '."version"')
# PHP_VERSION_MINOR=$(echo $PHP_VERSION | awk -F. '{ print $1 "." $2 }')
# PHP_TARBZ2_FILENAME=$(echo ${RELEASES} | jq -r '.source[] | select(.filename | contains("tar.bz2")) | .filename')
# PHP_TARBZ2_SHA256=$(echo ${RELEASES} | jq -r '.source[] | select(.filename | contains("tar.bz2")) | .sha256')
# PHP_TARBZ2_URL="https://php.net/get/'$PHP_TARBZ2_FILENAME'/from/this/mirror"
# PHP_BRANCH_NUM=$(echo $PHP_VERSION | awk -F. '{ print $1 $2 }')
# PHP_REVISION=$(bash -c 'echo $PHP_REVISION_'$PHP_BRANCH_NUM)

PHP_VERSION=$(curl -L --silent "https://phpreleases.com/api/releases/$VERSION" | jq '(.[0].major|tostring) + "." + (.[0].minor|tostring) + "." + (.[0].release|tostring)' --raw-output)
PHP_VERSION_MINOR=$(echo $PHP_VERSION | awk -F. '{ print $1 "." $2 }')
PHP_TARGZ_FILENAME=$(echo ${RELEASES} | jq -r '.source[] | select(.filename | contains("tar.bz2")) | .filename')
PHP_TARGZ_SHA256=$(curl -s -L "https://github.com/php/php-src/archive/refs/tags/php-${PHP_VERSION}.tar.gz" | sha256sum | awk '{ print $1 }')
PHP_TARGZ_URL="https://github.com/php/php-src/archive/refs/tags/php-${PHP_VERSION}.tar.gz"
PHP_BRANCH_NUM=$(echo $PHP_VERSION | awk -F. '{ print $1 $2 }')
PHP_REVISION=$(bash -c 'echo $PHP_REVISION_'$PHP_BRANCH_NUM)

export CONFIG='module Php'$PHP_BRANCH_NUM'Defs
    PHP_SRC_URL = "'$PHP_TARGZ_URL'".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "'$PHP_VERSION_MINOR'".freeze
    PHP_VERSION     = "'$PHP_VERSION'".freeze
    PHP_REVISION    = '$PHP_REVISION'.freeze
    PHP_BRANCH      = "PHP-'$PHP_VERSION_MINOR'".freeze
    PHP_BRANCH_NUM  = "'$PHP_BRANCH_NUM'".freeze

    PHP_CHECKSUM    = {
      :sha256 => "'$PHP_TARGZ_SHA256'",
    }.freeze
  end'

perl -i -p0e 's/module Php'$(echo $PHP_VERSION | awk -F. '{ print $1 "" $2 }')'Defs.*?end/'\$ENV{"CONFIG"}'/s' ${DIR}/Abstract/abstract-php-version.rb
done

if git status --porcelain 2>&1 | grep 'Abstract/abstract-php-version.rb'; then
  git add "Abstract/abstract-php-version.rb"
  #git commit -m "php version update"
  #git push
fi
