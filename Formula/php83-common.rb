require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php83Common < AbstractPhpCommon
  include AbstractPhpVersion::Php83Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.14-106"
    sha256 cellar: :any_skip_relocation, ventura:      "71f4ea36f04e08f338732c78a85b70c6b611abe08b1c69215259014c78c25ae2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "620fddb179f1feb3e3b4ec6330c1803e289e45991402a49630917069aac0fb29"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
