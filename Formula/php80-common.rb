require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php80Common < AbstractPhpCommon
  include AbstractPhpVersion::Php80Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
