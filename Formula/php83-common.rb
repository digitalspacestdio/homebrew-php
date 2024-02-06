require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php83Common < AbstractPhpCommon
  include AbstractPhpVersion::Php83Defs

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83-common"
    sha256 cellar: :any_skip_relocation, sonoma: "d5e81338ad48038a8c92f72c443b8108c4b6122d2855637bdb3cf410e3476c02"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
