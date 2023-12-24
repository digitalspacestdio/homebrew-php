require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php82Common < AbstractPhpCommon
  include AbstractPhpVersion::Php82Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
