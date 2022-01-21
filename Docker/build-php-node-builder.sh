#!/bin/bash
set -e
set -x
cd $(dirname $0)
set -o allexport
source .env
set +o allexport
repository=${1-digitalspacestudio}
# Assemble universal builder
docker buildx build --push --platform linux/amd64,linux/arm64 $DOCKER_BUILD_BUILDER_ARGS \
    --build-arg "BREW_FORMULAS_PHP=$FORMULAS_PHP" \
    --build-arg "BREW_FORMULAS_NODE=$FORMULAS_NODE" \
    --build-arg "BREW_FORMULAS_EXTRA=$FORMULAS_EXTRA" \
    -t "$repository/php-node-builder" \
    php-node-builder
