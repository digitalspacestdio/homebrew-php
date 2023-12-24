require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php81Common < AbstractPhpCommon
  include AbstractPhpVersion::Php81Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
