require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php73Common < AbstractPhpCommon
  include AbstractPhpVersion::Php73Defs

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73-common"
    sha256 cellar: :any_skip_relocation, sonoma: "f3a60b2d425ba9f0e5aa328782412c9f9127f492b5e25c2c5b8f3ddc5e1e5683"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
