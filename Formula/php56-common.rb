require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php56Common < AbstractPhpCommon
  include AbstractPhpVersion::Php56Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
