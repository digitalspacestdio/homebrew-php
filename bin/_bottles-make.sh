#!/bin/bash
set -e
if [[ ! -z $DEBUG ]]; then set -x; fi
if [[ -z $1 ]]; then
    echo "Usage $0 <FORMULA_NAME>"
    exit 1;
fi
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
brew tap digitalspacestdio/php
#cd $(brew tap-info --json digitalspacestdio/php | jq -r '.[].path')
#git stash
#git pull

for ARG in "$@"
do
    FORMULAS=$(brew search digitalspacestdio/php | awk -F'/' '{print $3}' | grep "^\($ARG\|$ARG@[0-9\.]\+\)\$" | sort)
    echo "==> Next formulas found:"
    echo -e "\033[33m==> The following formulas are matched:\033[0m"
    echo "$FORMULAS"
    sleep 5
    for FORMULA in $FORMULAS; do
        echo -e "\033[33m==> Creating bottles for $FORMULA ...\033[0m"
        brew list | grep -i $(echo $FORMULA | awk -F\@ '{ print $1 }') | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf -- '--no-run-if-empty'; fi;) -I{} brew uninstall --force --ignore-dependencies {}
        rm -rf ${HOME}/.bottles/$FORMULA.bottle
        mkdir -p ${HOME}/.bottles/$FORMULA.bottle
        cd ${HOME}/.bottles/$FORMULA.bottle

        echo "==> Installing dependencies for $FORMULA ..."

        # while read formulaDep; do
        #     brew uninstall -f --ignore-dependencies {} || /usr/bin/true
        # done < <(brew deps --direct $FORMULA | grep $FORMULA)

        # brew deps --direct $FORMULA | grep $FORMULA | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf '--no-run-if-empty'; fi;) -I{} bash -c 'brew uninstall -f --ignore-dependencies {} || /usr/bin/true'
        if brew deps --direct $FORMULA | grep $FORMULA | grep -v $FORMULA"$" > /dev/null; then
            if brew deps $(brew deps --direct $FORMULA | grep $FORMULA | grep -v $FORMULA"$") | grep -v $FORMULA > /dev/null; then
                DEPS=$(brew deps $(brew deps --direct $FORMULA | grep $FORMULA | grep -v $FORMULA"$") | grep -v $FORMULA)
                echo -e "\033[33m==> Installing dependencies ($DEPS) for $FORMULA ..."
                echo -e "\033[0m"
                brew install --quiet $DEPS
            fi
        fi

        echo "==> Building bottles for $FORMULA ..."
        [[ "true" == $(brew info  --json=v1 $FORMULA | jq '.[0].installed[0].built_as_bottle') ]] || {
            echo "==> Removing previously installed formula $FORMULA ..."
            sleep 3
            brew uninstall --force --ignore-dependencies $FORMULA
        }

        brew install --quiet --build-bottle $FORMULA 2>&1
        brew bottle --skip-relocation --no-rebuild --root-url 'https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/'$FORMULA --json $FORMULA
        ls | grep $FORMULA'.*--.*.gz$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf -- '--no-run-if-empty'; fi;) -I{} bash -c 'mv {}'
        ls | grep $FORMULA'.*--.*.json$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf -- '--no-run-if-empty'; fi;) -I{} bash -c 'mv {}'
        cd $(brew tap-info --json digitalspacestdio/php | jq -r '.[].path')
    done
done

