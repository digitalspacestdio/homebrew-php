#!/bin/bash
set -e
if [[ ! -z $DEBUG ]]; then set -x; fi
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
brew tap digitalspacestdio/common
brew tap digitalspacestdio/php
cd $(brew tap-info --json digitalspacestdio/php | jq -r '.[].path')

BACKUP_ETC_PHP_DIR=$(brew --prefix)/etc/php.$(date +'%Y%m%d%H%M%S')
if [[ -d $(brew --prefix)/etc/php ]]; then
    echo "==> Backing up the etc folder to: ${BACKUP_ETC_PHP_DIR}"
    mv "$(brew --prefix)/etc/php" "${BACKUP_ETC_PHP_DIR}";
fi

FORMULAS=${@:-$(brew search digitalspacestdio/php | grep 'php[5-9]\{1\}[0-9]\{1\}$' | awk -F'/' '{ print $3 }' | sort)}
for PHP_FORMULA in $FORMULAS; do
    PHP_BOTTLES_FOLDER=$(brew info --json=v1 $PHP_FORMULA | jq -r '.[].versions.stable')-$(brew info --json=v1 $PHP_FORMULA | jq -r '.[].revision')
    PHP_COMMON_DEPS=$(brew deps --direct $PHP_FORMULA-common | grep $PHP_FORMULA)

    echo "==> Creating bottles for $PHP_BOTTLES_FOLDER..."
    rm -rf ${HOME}/.bottles/$PHP_FORMULA.bottle
    mkdir -p ${HOME}/.bottles/$PHP_FORMULA.bottle
    cd ${HOME}/.bottles/$PHP_FORMULA.bottle

    echo "==> Re-installing dependencies for $PHP_FORMULA ..."
    echo "$PHP_COMMON_DEPS" | xargs -I{} bash -c 'brew uninstall -f --ignore-dependencies {} || /usr/bin/true'
    brew install --quiet $(brew deps $(echo "$PHP_COMMON_DEPS" | grep -v $PHP_FORMULA"$") | grep -v $PHP_FORMULA)

    echo "==> Building $PHP_BOTTLES_FOLDER ..."
    brew install --quiet --build-bottle $PHP_COMMON_DEPS 2>&1
    brew install --quiet --build-bottle $(brew info --json=v1 $PHP_FORMULA-common | jq -r '.[].full_name') 2>&1

    echo "==> Bottling $PHP_BOTTLES_FOLDER ..."
    brew bottle --skip-relocation --no-rebuild --root-url 'https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/'$PHP_BOTTLES_FOLDER --json $(brew deps --direct $PHP_FORMULA-common)
    brew bottle --skip-relocation --no-rebuild --root-url 'https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/'$PHP_BOTTLES_FOLDER --json $(brew info --json=v1 $PHP_FORMULA-common | jq -r '.[].full_name')

    ls | grep $PHP_FORMULA'.*--.*.gz$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf -- '--no-run-if-empty'; fi;) -I{} bash -c 'mv {}'
    ls | grep $PHP_FORMULA'.*--.*.json$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf -- '--no-run-if-empty'; fi;) -I{} bash -c 'mv {}'
done

if [[ -d "${BACKUP_ETC_PHP_DIR}" ]]; then
    echo "Restoring the etc folder from: ${BACKUP_ETC_PHP_DIR}"
    mv "${BACKUP_ETC_PHP_DIR}" "$(brew --prefix)/etc/php";
fi
