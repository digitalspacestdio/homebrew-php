require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php83Common < AbstractPhpCommon
  include AbstractPhpVersion::Php83Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.17-111"
    sha256 cellar: :any_skip_relocation, ventura:      "13786a87e4b8add77593943e736f5c79bd12ffc55188ad126d848e395edbfa56"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "da5d50f7a37c940e65c2015ac49995e39fc99dcdb8fa52b515ed774f368fe6d9"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
