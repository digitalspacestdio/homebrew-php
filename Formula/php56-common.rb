require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php56Common < AbstractPhpCommon
  include AbstractPhpVersion::Php56Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/5.6.40-103"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3a204f6082d8b05818f96276a683b0b2deaca67a87790c5ebd3626c2200d16be"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
