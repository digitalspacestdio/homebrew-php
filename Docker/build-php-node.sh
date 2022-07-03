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
    php_version=$(docker run --rm $repository/linuxbrew sh -c "brew tap digitalspacestdio/php && brew info ${formula_php} --json" | jq '.[].versions.stable' | grep -o '[0-9]\+\.[0-9]\+\.[0-9A-Za-z]\+')
    php_major=$(echo $php_version | awk -F. '{print $1}')
    php_minor=$(echo $php_version | awk -F. '{print $2}')
    php_fix=$(echo $php_version | awk -F. '{print $3}')
    versions_php=("$versions_php $php_major.$php_minor.$php_fix")
done

versions_php="$(echo $versions_php | tr ' ' '\n' | sort)"

for php_version in $versions_php; do
  for formula_node in $FORMULAS_NODE; do
    php_major=$(echo $php_version | awk -F. '{print $1}')
    php_minor=$(echo $php_version | awk -F. '{print $2}')
    php_fix=$(echo $php_version | awk -F. '{print $3}')
    php_fix_major_minor_fix="$repository/php:$php_major.$php_minor.$php_fix";
    php_fix_major_minor="$repository/php:$php_major.$php_minor";
    php__major="$repository/php:$php_major";

    node_version=$(docker run --rm $repository/linuxbrew sh -c "brew info ${formula_node} --json" | jq '.[].versions.stable' | grep -o '[0-9]\+\.[0-9]\+\.[0-9A-Za-z]\+')

    node_major=$(echo $node_version | awk -F. '{print $1}')
    node_minor=$(echo $node_version | awk -F. '{print $2}')
    node_fix=$(echo $node_version | awk -F. '{print $3}')

#    FROM_IMAGE_BUILDER=${DOCKER_IMAGE_BUILDER} \
#    FROM_IMAGE_PHP="$repository/php:$php_version" \
#    FROM_IMAGE="$repository/linuxbrew" \

    docker buildx build --push --platform linux/amd64,linux/arm64 $DOCKER_BUILD_PHP_ARGS \
    --build-arg FROM_IMAGE_BUILDER="${DOCKER_IMAGE_BUILDER}" \
    --build-arg FROM_IMAGE_PHP="$repository/php:$php_version" \
    --build-arg FROM_IMAGE="debian:bullseye-slim" \
    --build-arg BREW_FORMULA_NODE="$formula_node" \
    -t "$repository/php-node:$php_major.$php_minor.$php_fix-$node_major.$node_minor.$node_fix" \
    -t "$repository/php-node:$php_major.$php_minor-$node_major.$node_minor" \
    -t "$repository/php-node:$php_major.$php_minor-$node_major" \
    php-node
  done
done
