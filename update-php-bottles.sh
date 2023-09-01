#!/bin/bash
set -x
set -e
if [[ -z $1 ]]; then
    exit 1;
fi

brew untap -f digitalspacestdio/php || /usr/bin/true
brew untap -f digitalspacestdio/common || /usr/bin/true

brew tap digitalspacestdio/common
brew tap digitalspacestdio/php

PHP_FORMULA=$1
rm -rf /tmp/$PHP_FORMULA.bottle
mkdir -p /tmp/$PHP_FORMULA.bottle
cd /tmp/$PHP_FORMULA.bottle
brew deps --direct $PHP_FORMULA-common | xargs brew uninstall --ignore-dependencies || /usr/bin/true
brew install $(brew deps --direct $PHP_FORMULA)
brew install $(brew deps --direct $PHP_FORMULA-common | xargs -I{} bash -c 'brew deps --direct {}' | sort | uniq -u | grep -v $PHP_FORMULA)
brew install --build-bottle $(brew deps --direct $PHP_FORMULA-common)
brew bottle --no-rebuild --root-url 'https://f003.backblazeb2.com/file/homebrew-bottles/'$PHP_FORMULA --json $(brew deps --direct $PHP_FORMULA-common)
ls | grep $PHP_FORMULA'.*json$' | xargs -I{} bash -c 'brew bottle --merge --write --json {}'
ls | grep $PHP_FORMULA'.*gz$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs -I{} bash -c 'mv {}'
cd -
