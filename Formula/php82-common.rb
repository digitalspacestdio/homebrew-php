require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php82Common < AbstractPhpCommon
  include AbstractPhpVersion::Php82Defs
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1f3738e4f40079d3d01c863be5bd98f301e55222852febfffded59e116a49422"
    sha256 cellar: :any_skip_relocation, monterey:      "c95db9ef89979fa721605fc8792722a0c124142e1f8ff3e2f650d5e9d98316c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a4f6de9c1c2d845dc542811bcec96569bfc1e835978718777d5d3d7aa54553ea"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
