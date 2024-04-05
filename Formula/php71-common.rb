require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php71Common < AbstractPhpCommon
  include AbstractPhpVersion::Php71Defs
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "34037616ff0170e0e6efb5d88cf0c14aaa9b5966f8999bf161f3625de4b304bf"
    sha256 cellar: :any_skip_relocation, sonoma:        "bf5663406515cce57eb73853b146277cc6494a6cc2b5a6a9c923a56e50cbf441"
    sha256 cellar: :any_skip_relocation, monterey:      "8e82bdc3234f1417bd641950054722b382c53ad749126725c2ae697080c5f406"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b7a6e8022aa5a90ba8d786636294bc1c45aba2d09d39ffd782e56efc163b54a9"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
