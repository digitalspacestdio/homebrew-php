#!/bin/bash
set -x
set -e
if [[ -z $1 ]]; then
    exit 1;
fi
export HOMEBREW_NO_AUTO_UPDATE=1
brew tap digitalspacestdio/common
brew tap digitalspacestdio/php
cd $(brew tap-info --json digitalspacestdio/php | jq -r '.[].path')
git fetch --all
git reset --hard origin/master

PHP_FORMULA=$1
rm -rf /tmp/$PHP_FORMULA.bottle
mkdir -p /tmp/$PHP_FORMULA.bottle
cd /tmp/$PHP_FORMULA.bottle
brew deps --direct $PHP_FORMULA-common | grep $PHP_FORMULA | xargs -I{} bash -c 'brew uninstall --ignore-dependencies {} || /usr/bin/true'
brew install $(brew deps --direct $PHP_FORMULA | grep -v $PHP_FORMULA)
brew install $(brew deps --direct $PHP_FORMULA-common | xargs -I{} bash -c 'brew deps --direct {}' | sort | uniq -u | grep -v $PHP_FORMULA)
brew install --build-bottle $(brew deps --direct $PHP_FORMULA-common | grep $PHP_FORMULA)
brew bottle --skip-relocation --no-rebuild --root-url 'https://f003.backblazeb2.com/file/homebrew-bottles/'$PHP_FORMULA --json $(brew deps --direct $PHP_FORMULA-common)
ls | grep $PHP_FORMULA'.*--.*.gz$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf '--no-run-if-empty'; fi;) -I{} bash -c 'mv {}'
ls | grep $PHP_FORMULA'.*--.*.json$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf '--no-run-if-empty'; fi;) -I{} bash -c 'mv {}'
cd $(brew tap-info --json digitalspacestdio/php | jq -r '.[].path')
