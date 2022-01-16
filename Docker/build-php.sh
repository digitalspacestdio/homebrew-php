#!/bin/bash
set -e
set -x
cd $(dirname $0)
set -o allexport
source .env
set +o allexport
repository=${1-digitalspacestudio}
versions_php=()

DOCKER_IMAGE_BUILDER=${DOCKER_IMAGE_BUILDER-"$repository/php-node-builder"}

for formula_php in $FORMULAS_PHP; do
    php_version=$(docker run --rm $repository/linuxbrew sh -c "brew tap digitalspacestdio/php && brew info ${formula_php} --json" | jq '.[].versions.stable' | egrep -o '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][A-z0-9]*')
    versions_php+=("$php_version")
    php_major=$(echo $php_version | awk -F. '{print $1}')
    php_minor=$(echo $php_version | awk -F. '{print $2}')
    php_fix=$(echo $php_version | awk -F. '{print $3}')

#    FROM_IMAGE_BUILDER=${DOCKER_IMAGE_BUILDER} \
#    FROM_IMAGE="$repository/linuxbrew" \

    docker buildx build --push --platform linux/amd64,linux/arm64 $DOCKER_BUILD_PHP_ARGS \
    --build-arg FROM_IMAGE_BUILDER=$DOCKER_IMAGE_BUILDER \
    --build-arg FROM_IMAGE="debian:bullseye-slim" \
    --build-arg BREW_FORMULA_PHP="$formula_php" \
    -t "$repository/php:$php_major.$php_minor.$php_fix" \
    -t "$repository/php:$php_major.$php_minor" \
    php
done
