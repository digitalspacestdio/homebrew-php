#!/bin/bash
set -e
if [[ ! -z $DEBUG ]]; then set -x; fi
if [[ -z $1 ]]; then
    exit 1;
fi
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
brew tap digitalspacestdio/common
brew tap digitalspacestdio/php
cd $(brew tap-info --json digitalspacestdio/php | jq -r '.[].path')
git stash
#git pull

BACKUP_ETC_PHP_DIR=$(brew --prefix)/etc/php.$(date +'%Y%m%d%H%M%S')
if [[ -d $(brew --prefix)/etc/php ]]; then
    echo "==> Backing up the etc folder to: ${BACKUP_ETC_PHP_DIR}"
    mv "$(brew --prefix)/etc/php" "${BACKUP_ETC_PHP_DIR}";
fi

FORMULAS=${@:-$(brew search digitalspacestdio/php | grep 'php[5-9]\{1\}[0-9]\{1\}$' | awk -F'/' '{ print $3 }' | sort)}
for PHP_FORMULA in $FORMULAS; do
    echo "==> Creating bottles for $PHP_FORMULA ..."
    rm -rf ${HOME}/.bottles/$PHP_FORMULA.bottle
    mkdir -p ${HOME}/.bottles/$PHP_FORMULA.bottle
    cd ${HOME}/.bottles/$PHP_FORMULA.bottle

    echo "==> Installing dependencies for $PHP_FORMULA ..."
    brew deps --direct $PHP_FORMULA-common | grep $PHP_FORMULA | xargs -I{} bash -c 'brew uninstall -f --ignore-dependencies {} || /usr/bin/true'
    brew install --quiet $(brew deps $(brew deps --direct $PHP_FORMULA-common | grep $PHP_FORMULA | grep -v $PHP_FORMULA"$") | grep -v $PHP_FORMULA)
    #brew install $(brew deps --direct $PHP_FORMULA | grep -v $PHP_FORMULA)
    #brew install $(brew deps --direct $PHP_FORMULA-common | xargs -I{} bash -c 'brew deps --direct {}' | sort | uniq -u | grep -v $PHP_FORMULA)

    echo "==> Building bottles for $PHP_FORMULA ..."
    brew install --quiet --build-bottle $(brew deps --direct $PHP_FORMULA-common | grep $PHP_FORMULA) 2>&1
    brew bottle --skip-relocation --no-rebuild --root-url 'https://f003.backblazeb2.com/file/homebrew-bottles/'$PHP_FORMULA --json $(brew deps --direct $PHP_FORMULA-common)
    ls | grep $PHP_FORMULA'.*--.*.gz$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf -- '--no-run-if-empty'; fi;) -I{} bash -c 'mv {}'
    ls | grep $PHP_FORMULA'.*--.*.json$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf -- '--no-run-if-empty'; fi;) -I{} bash -c 'mv {}'
    cd $(brew tap-info --json digitalspacestdio/php | jq -r '.[].path')
done

if [[ -d "${BACKUP_ETC_PHP_DIR}" ]]; then
    echo "Restoring the etc folder from: ${BACKUP_ETC_PHP_DIR}"
    mv "${BACKUP_ETC_PHP_DIR}" "$(brew --prefix)/etc/php";
fi
