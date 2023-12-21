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
cd /tmp/$PHP_FORMULA.bottle
ls | grep $PHP_FORMULA'.*--.*.gz$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf '--no-run-if-empty'; fi;) -I{} bash -c 'mv {}'
ls | grep $PHP_FORMULA'.*--.*.json$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf '--no-run-if-empty'; fi;) -I{} bash -c 'mv {}'
for jsonfile in ./*.json; do
    jsonfile=$(basename $jsonfile)
    JSON_FORMULA_NAME=$(jq -r '.[].formula.name' "$jsonfile")
    if ! [[ -z $JSON_FORMULA_NAME ]]; then
        mergedfile=$(jq -r '.["digitalspacestdio/php/'$JSON_FORMULA_NAME'"].formula.name + "-" + ."digitalspacestdio/php/'$JSON_FORMULA_NAME'".formula.pkg_version + ".json"' "$jsonfile")
        while read tgzName; do
            if [[ -f "$tgzName" ]]; then
                s3cmd info "s3://homebrew-bottles/$PHP_FORMULA/$tgzName" >/dev/null && {
                    s3cmd del "s3://homebrew-bottles/$PHP_FORMULA/$tgzName"
                } || /usr/bin/true
                s3cmd put "$tgzName" "s3://homebrew-bottles/$PHP_FORMULA/$tgzName"
            fi
        done < <(jq -r '."digitalspacestdio/php/'$JSON_FORMULA_NAME'".bottle.tags[].filename' "$jsonfile")
        s3cmd info "s3://homebrew-bottles/$PHP_FORMULA/$mergedfile" >/dev/null && {
            s3cmd get "s3://homebrew-bottles/$PHP_FORMULA/$mergedfile" "$mergedfile".src
            if [[ "object" != $(cat "$mergedfile".src| jq -r type) ]]; then
                cp "$jsonfile" "$mergedfile".src
            fi
            jq -s  '.[1]."digitalspacestdio/php/'$JSON_FORMULA_NAME'".bottle.tags = .[0]."digitalspacestdio/php/'$JSON_FORMULA_NAME'".bottle.tags * .[1]."digitalspacestdio/php/'$JSON_FORMULA_NAME'".bottle.tags | .[1]' "$mergedfile".src "$jsonfile" > "$mergedfile"
            s3cmd del "s3://homebrew-bottles/$PHP_FORMULA/$mergedfile"
            s3cmd put "$mergedfile" "s3://homebrew-bottles/$PHP_FORMULA/$mergedfile"
            brew bottle --skip-relocation --no-rebuild --merge --write --json "$mergedfile"
            rm "$mergedfile" "$mergedfile".src
        } || {
            s3cmd put "$jsonfile" "s3://homebrew-bottles/$PHP_FORMULA/$mergedfile"
            brew bottle --skip-relocation --no-rebuild --merge --write --json "$jsonfile"
        }
    fi
done
git pull --rebase
git push
cd -
