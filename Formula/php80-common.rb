require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php80Common < AbstractPhpCommon
  include AbstractPhpVersion::Php80Defs

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80-common"
    sha256 cellar: :any_skip_relocation, sonoma:       "d7d03e36cadf3acd5396216bb9569a6c9b533a4f4231e915619db29a7d76c845"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ced08cab2c456ec67fc6f1b197264c412cc50fafbbdef415c96ee91a327915c0"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
