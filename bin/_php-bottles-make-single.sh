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
    PHP_MAIN_FORMULA=$(echo $PHP_FORMULA | awk -F\- '{ print $1 }' | grep '^php[0-9]\+$')
    if [[ -n $PHP_MAIN_FORMULA ]]; then
        PHP_BOTTLES_FOLDER=$(brew info --json=v1 $PHP_MAIN_FORMULA | jq -r '.[].versions.stable')-$(brew info --json=v1 $PHP_MAIN_FORMULA | jq -r '.[].revision')

        echo "==> Creating bottles for $PHP_FORMULA..."
        echo "==> Workdir: ${HOME}/.bottles/$PHP_MAIN_FORMULA.bottle"
        rm -rf ${HOME}/.bottles/$PHP_MAIN_FORMULA.bottle
        mkdir -p ${HOME}/.bottles/$PHP_MAIN_FORMULA.bottle
        cd ${HOME}/.bottles/$PHP_MAIN_FORMULA.bottle

        echo "==> Building $PHP_FORMULA ..."
        brew install --quiet --build-bottle $(brew info --json=v1 $PHP_FORMULA | jq -r '.[].full_name') 2>&1

        echo "==> Bottling $PHP_FORMULA ..."
        brew bottle --skip-relocation --no-rebuild --root-url 'https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/'$PHP_BOTTLES_FOLDER --json $(brew info --json=v1 $PHP_FORMULA | jq -r '.[].full_name')

        echo "==> Renaming files $PHP_FORMULA ..."
        ls | grep $PHP_FORMULA'.*--.*.gz$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf -- '--no-run-if-empty'; fi;) -I{} bash -c 'mv {}'
        ls | grep $PHP_FORMULA'.*--.*.json$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf -- '--no-run-if-empty'; fi;) -I{} bash -c 'mv {}'
    fi
done

if [[ -d "${BACKUP_ETC_PHP_DIR}" ]]; then
    echo "Restoring the etc folder from: ${BACKUP_ETC_PHP_DIR}"
    mv "${BACKUP_ETC_PHP_DIR}" "$(brew --prefix)/etc/php";
fi
