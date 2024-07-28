#!/bin/bash
set -e
if [[ ! -z $DEBUG ]]; then set -x; fi
#if [[ -z $1 ]]; then
#    exit 1;
#fi
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
brew tap digitalspacestdio/common
brew tap digitalspacestdio/php
cd $(brew tap-info --json digitalspacestdio/php | jq -r '.[].path')
#git stash
#git pull
S3_BUCKET="homebrew";
S3_BASEDIR="php"
ALLOW_REPLACE=${ALLOW_REPLACE:-""}

function uri_extract_path {
    # extract the protocol
    proto="$(echo $1 | grep :// | sed -e's,^\(.*://\).*,\1,g')"

    # remove the protocol -- updated
    url=$(echo $1 | sed -e s,$proto,,g)

    # extract the user (if any)
    user="$(echo $url | grep @ | cut -d@ -f1)"

    # extract the host and port -- updated
    hostport=$(echo $url | sed -e s,$user@,,g | cut -d/ -f1)

    # by request host without port
    host="$(echo $hostport | sed -e 's,:.*,,g')"
    # by request - try to extract the port
    port="$(echo $hostport | sed -e 's,^.*:,:,g' -e 's,.*:\([0-9]*\).*,\1,g' -e 's,[^0-9],,g')"

    # extract the path (if any)
    path="$(echo $url | grep / | cut -d/ -f2-)"

    echo $path
}

FORMULAS=${@:-$(brew search digitalspacestdio/php | grep 'php[5-9]\{1\}[0-9]\{1\}$' | awk -F'/' '{ print $3 }' | sort)}
echo "--> Starting bottles upload for $FORMULAS ..."
echo "--> Checking permissions 's3://$S3_BUCKET' ..."
for PHP_FORMULA in $FORMULAS; do
    PHP_MAIN_FORMULA=$(echo $PHP_FORMULA | awk -F\- '{ print $1 }' | grep '^php[0-9]\+$')
    if [[ -n $PHP_MAIN_FORMULA ]]; then
        s3cmd info "s3://$S3_BUCKET" > /dev/null
        cd ${HOME}/.bottles/$PHP_MAIN_FORMULA.bottle
        ls | grep $PHP_FORMULA'.*--.*.gz$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf -- '--no-run-if-empty'; fi;) -I{} bash -c 'mv {}'
        ls | grep $PHP_FORMULA'.*--.*.json$' | awk -F'--' '{ print $0 " " $1 "-" $2 }' | xargs $(if [[ "$OSTYPE" != "darwin"* ]]; then printf -- '--no-run-if-empty'; fi;) -I{} bash -c 'mv {}'

        for jsonfile in ./*.json; do
            jsonfile=$(basename $jsonfile)
            JSON_FORMULA_NAME=$(jq -r '.[].formula.name' "$jsonfile")
            S3_BASE_PATH=$(uri_extract_path $(jq -r '.[].bottle.root_url' "$jsonfile"))
            
            # If the bucket is absent in the base url we need to add it for s3cmd
            if [[ $S3_BASE_PATH != "${S3_BUCKET}/*" ]]; then
                S3_BASE_PATH=${S3_BUCKET}/${S3_BASE_PATH}
            fi

            if ! [[ -z $JSON_FORMULA_NAME ]]; then
                while read tgzName; do
                    if [[ -f "$tgzName" ]]; then
                        echo "--> Checking is file does not exists 's3://$S3_BASE_PATH/$tgzName' ..."
                        s3cmd info "s3://$S3_BASE_PATH/$tgzName" > /dev/null 2>&1 && {
                            if [[ -z $ALLOW_REPLACE ]]; then
                                echo "--> File exists s3://$S3_BASE_PATH/$tgzName"
                                echo "--> Skipping..."
                                continue 2
                            else
                                echo "--> File exists s3://$S3_BASE_PATH/$tgzName"
                                echo "--> Replacing..."
                            fi
                        }
                        s3cmd put "$tgzName" "s3://$S3_BASE_PATH/$tgzName"
                    fi
                done < <(jq -r '."digitalspacestdio/php/'$JSON_FORMULA_NAME'".bottle.tags[].filename' "$jsonfile")
            
                mergedfile=$(jq -r '.["digitalspacestdio/php/'$JSON_FORMULA_NAME'"].formula.name + "-" + ."digitalspacestdio/php/'$JSON_FORMULA_NAME'".formula.pkg_version + ".json"' "$jsonfile")
                echo "--> Uploading: 's3://$S3_BASE_PATH/$mergedfile'"
                echo "--> Checking is file exists 's3://$S3_BASE_PATH/$mergedfile' ..."
                s3cmd info "s3://$S3_BASE_PATH/$mergedfile" > /dev/null 2>&1 && {
                    echo "--> File exists, merging 's3://$S3_BASE_PATH/$mergedfile' ..."
                    s3cmd get "s3://$S3_BASE_PATH/$mergedfile" "$mergedfile".src
                    if [[ "object" != $(cat "$mergedfile".src| jq -r type) ]]; then
                        cp "$jsonfile" "$mergedfile".src
                    fi
                    jq -s  '.[1]."digitalspacestdio/php/'$JSON_FORMULA_NAME'".bottle.tags = .[0]."digitalspacestdio/php/'$JSON_FORMULA_NAME'".bottle.tags * .[1]."digitalspacestdio/php/'$JSON_FORMULA_NAME'".bottle.tags | .[1]' "$mergedfile".src "$jsonfile" > "$mergedfile"
                    s3cmd del "s3://$S3_BASE_PATH/$mergedfile"
                    s3cmd put "$mergedfile" "s3://$S3_BASE_PATH/$mergedfile"
                    brew bottle --skip-relocation --no-rebuild --merge --write --no-commit --json "$mergedfile"
                    rm "$mergedfile" "$mergedfile".src
                } || {
                    echo "--> File absent, uploading 's3://$S3_BASE_PATH/$mergedfile' ..."
                    s3cmd put "$jsonfile" "s3://$S3_BASE_PATH/$mergedfile"
                    brew bottle --skip-relocation --no-rebuild --merge --write --no-commit --json "$jsonfile"
                } || exit 1
            fi
        done
    fi
done
cd $(brew tap-info --json digitalspacestdio/php | jq -r '.[].path')
git add .
git commit -m "bottles update: $FORMULAS"
echo "merge" | git pull --no-rebase
git push
cd -
