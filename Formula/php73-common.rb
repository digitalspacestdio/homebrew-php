require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php73Common < AbstractPhpCommon
  include AbstractPhpVersion::Php73Defs

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "64fc5c873f96bc183420cf0b19dd52702d44f698e0e9625b51963ec13c9524eb"
    sha256 cellar: :any_skip_relocation, sonoma:        "f3a60b2d425ba9f0e5aa328782412c9f9127f492b5e25c2c5b8f3ddc5e1e5683"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "13fc32b614ee930dbffd6cf9cc008cc0bcbd990c81dd2d9944d735e3acfcf90c"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
