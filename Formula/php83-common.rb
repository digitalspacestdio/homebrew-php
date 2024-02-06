require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php83Common < AbstractPhpCommon
  include AbstractPhpVersion::Php83Defs

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "011f0d55cfb1be2d33e7e11cde1689abf781d3597683542909c4312a0a84faed"
    sha256 cellar: :any_skip_relocation, sonoma:        "d5e81338ad48038a8c92f72c443b8108c4b6122d2855637bdb3cf410e3476c02"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1be43cde96405f5ad2221dc6f4aae8269d82ddc8e74177378be57a3d847c3efc"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
