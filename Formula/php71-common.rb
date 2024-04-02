require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php71Common < AbstractPhpCommon
  include AbstractPhpVersion::Php71Defs
  revision PHP_REVISION
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
