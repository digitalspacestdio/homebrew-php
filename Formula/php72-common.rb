require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php72Common < AbstractPhpCommon
  include AbstractPhpVersion::Php72Defs

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72-common"
    sha256 cellar: :any_skip_relocation, sonoma: "cfde4ed4c7a01acd51ddb18c3e9edb9fd437c2e3865d7726fa4b23bf1e440485"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
