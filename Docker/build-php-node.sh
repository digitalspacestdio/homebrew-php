#!/bin/bash
set -e
set -x
cd $(dirname $0)
repository=${1-digitalspacestudio}
image=php-node
formulas_php="digitalspacestdio/php/php80 digitalspacestdio/php/php74 digitalspacestdio/php/php73 digitalspacestdio/php/php72"
formulas_node="node node@14 node@12"
versions_php=()
for formula_php in $formulas_php; do
    php_version=$(docker run --rm digitalspacestudio/linuxbrew sh -c "brew tap digitalspacestdio/php && brew info ${formula_php} --json" | jq '.[].versions.stable' | egrep -o '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][A-z0-9]*')
    versions_php+=("$php_version")
    php_major=$(echo $php_version | awk -F. '{print $1}')
    php_minor=$(echo $php_version | awk -F. '{print $2}')
    php_fix=$(echo $php_version | awk -F. '{print $3}')

    docker build --rm \
    --build-arg "BREW_FORMULA_PHP=$formula_php" \
    -t "$repository/$image:$php_major.$php_minor.$php_fix" \
    -t "$repository/$image:$php_major.$php_minor" \
    php
done


for php_version in $php_version; do
  for formula_node in $formulas_node; do
    php_major=$(echo $php_version | awk -F. '{print $1}')
    php_minor=$(echo $php_version | awk -F. '{print $2}')
    php_fix=$(echo $php_version | awk -F. '{print $3}')
    php_fix_major_minor_fix = "$repository/$image:$php_major.$php_minor.$php_fix";
    php_fix_major_minor= "$repository/$image:$php_major.$php_minor";
    php__major = "$repository/$image:$php_major";

    node_version=$(docker run --rm digitalspacestudio/linuxbrew sh -c "brew info ${formula_node} --json" | jq '.[].versions.stable' | egrep -o '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][A-z0-9]*')

    node_major=$(echo $node_version | awk -F. '{print $1}')
    node_minor=$(echo $node_version | awk -F. '{print $2}')
    node_fix=$(echo $node_version | awk -F. '{print $3}')

    FROM_IMAGE="$repository/$image:$php_version" \
    docker build --rm \
    --build-arg "BREW_FORMULA_NODE=$formula_php" \
    -t "$repository/$image:$php_major.$php_minor.$php_fix-$node_major.$node_minor.$node_fix" \
    -t "$repository/$image:$php_major.$php_minor-$node_major.$node_minor" \
    -t "$repository/$image:$php_major.$php_minor-$node_major" \
    php-node
  done
done
