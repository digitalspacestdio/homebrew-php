require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php72Common < AbstractPhpCommon
  include AbstractPhpVersion::Php72Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
