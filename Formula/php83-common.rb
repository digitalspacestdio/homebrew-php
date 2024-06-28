require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php83Common < AbstractPhpCommon
  include AbstractPhpVersion::Php83Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.3.8-106"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "19a03879674b6a75d20189bb86e29f86e85ee7f62b98b95e5f2817496ee660c8"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
