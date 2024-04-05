require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php72Common < AbstractPhpCommon
  include AbstractPhpVersion::Php72Defs
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3dff55632c19a88b4eb34719807ac048da7fe7e0cf36ef673784d29d403e14ac"
    sha256 cellar: :any_skip_relocation, sonoma:        "cfde4ed4c7a01acd51ddb18c3e9edb9fd437c2e3865d7726fa4b23bf1e440485"
    sha256 cellar: :any_skip_relocation, monterey:      "4f9bd68dbd485524a5000331927afd08f66d6c23688ed0b9ba7a2b2e99060a9a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f555224603f06fa1268f9bb5a35f0d3b9b849ae10fb3e96d72ffab4dc3bcc79c"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
