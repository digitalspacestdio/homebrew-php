require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php73Common < AbstractPhpCommon
  include AbstractPhpVersion::Php73Defs
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 24
end
