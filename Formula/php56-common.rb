require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php56Common < AbstractPhpCommon
  include AbstractPhpVersion::Php56Defs
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56-common"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "370faaa69cc40373380df8fbe95226d46710d7e3168766e8a0d06d5fb752ab03"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
