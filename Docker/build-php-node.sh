#!/bin/bash
set -e
set -x
cd $(dirname $0)
repository=${1-digitalspacestudio}
image=php-node
formulas_php="digitalspacestdio/php/php80 digitalspacestdio/php/php74 digitalspacestdio/php/php73 digitalspacestdio/php/php72"
formulas_node="node node@14 node@12"
for formula_php in $formulas_php; do
  for formula_node in $formulas_node; do
    tag=$(echo $formula_php | md5 | cut -c-8)-$(echo $formula_node | md5 | cut -c-8)
    docker build --rm --build-arg "BREW_FORMULA_PHP=$formula_php" --build-arg "BREW_FORMULA_NODE=$formula_node" -t "$repository/$image:$tag" $image

    php_version=$(docker run --rm "$repository/$image:$tag" php -v | egrep -o 'PHP [0-9][0-9]*\.[0-9][0-9]*\.[0-9][A-z0-9]*' | egrep -o '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][A-z0-9]*' )
    php_major=$(echo $php_version | awk -F. '{print $1}')
    php_minor=$(echo $php_version | awk -F. '{print $2}')
    php_fix=$(echo $php_version | awk -F. '{print $3}')

    node_version=$(docker run --rm "$repository/$image:$tag" node -v | egrep -o 'v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][A-z0-9]*' | egrep -o '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][A-z0-9]*' )
    node_major=$(echo $node_version | awk -F. '{print $1}')
    node_minor=$(echo $node_version | awk -F. '{print $2}')
    node_fix=$(echo $node_version | awk -F. '{print $3}')

    docker tag "$repository/$image:$tag" "$repository/$image:$php_major.$php_minor.$php_fix-$node_major.$node_minor.$node_fix"
    docker tag "$repository/$image:$tag" "$repository/$image:$php_major.$php_minor.$php_fix-$node_major.$node_minor"
    docker tag "$repository/$image:$tag" "$repository/$image:$php_major.$php_minor-$node_major.$node_minor"
    docker tag "$repository/$image:$tag" "$repository/$image:$php_major.$php_minor-$node_major"

    docker push "$repository/$image:$php_major.$php_minor.$php_fix-$node_major.$node_minor.$node_fix"
    docker push "$repository/$image:$php_major.$php_minor.$php_fix-$node_major.$node_minor"
    docker push "$repository/$image:$php_major.$php_minor-$node_major.$node_minor"
    docker push "$repository/$image:$php_major.$php_minor-$node_major"
  done
done
