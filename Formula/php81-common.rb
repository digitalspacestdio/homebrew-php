require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php81Common < AbstractPhpCommon
  include AbstractPhpVersion::Php81Defs

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81-common"
    sha256 cellar: :any_skip_relocation, sonoma: "f49b8469774a8d19f43bb6f00d86fee65cdc0c021b1d5eee385942b1091fbeaf"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
