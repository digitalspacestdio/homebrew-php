#!/bin/bash
set -e
set -x
cd $(dirname $0)
set -o allexport
source .env
set +o allexport
repository=${1-digitalspacestudio}
formulas_deps=$(docker run --rm $repository/linuxbrew sh -c "brew tap digitalspacestdio/common && brew tap digitalspacestdio/php && brew-list-build-deps $FORMULAS_PHP $FORMULAS_NODE $FORMULAS_EXTRA")

# Assemble universal builder
docker buildx build --push --platform linux/amd64,linux/arm64 $DOCKER_BUILD_BUILDER_ARGS \
    --build-arg "BREW_FORMULA_DEPS=$formulas_deps" \
    -t "$repository/php-node-builder" \
    php-node-builder
