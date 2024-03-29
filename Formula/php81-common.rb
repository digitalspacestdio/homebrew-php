require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php81Common < AbstractPhpCommon
  include AbstractPhpVersion::Php81Defs
  revision PHP_REVISION
  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "67fc9972b24ccd01be5de06ad23c67b6614d60fc6a4033da78522d56cc124d15"
    sha256 cellar: :any_skip_relocation, sonoma:        "f49b8469774a8d19f43bb6f00d86fee65cdc0c021b1d5eee385942b1091fbeaf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa4c22719444ae8bc171eb90f11d6d91786eb3d1e19f0ff85306b62b6e04ea94"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
