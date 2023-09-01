#!/bin/bash
set -x
set -e
if [[ -z $1 ]]; then
    exit 1;
fi
brew update
PHP_FORMULA=$1
rm -rf /tmp/$PHP_FORMULA.bottle
mkdir -p /tmp/$PHP_FORMULA.bottle
cd /tmp/$PHP_FORMULA.bottle
formulas=$(brew deps --direct $PHP_FORMULA-common) 
brew uninstall --ignore-dependencies  $formulas
brew install --build-bottle $formulas
brew bottle --root-url 'https://f003.backblazeb2.com/file/homebrew-bottles' --json $formulas
ls | grep $PHP_FORMULA'.*json$' | xargs -I{} bash -c 'brew bottle --merge --write --json {}'
ls | grep $PHP_FORMULA'.*gz$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs -I{} bash -c 'mv {}'
cd -
rm -rf /tmp/$PHP_FORMULA.bottle
