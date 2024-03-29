require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php71Common < AbstractPhpCommon
  include AbstractPhpVersion::Php71Defs
  revision PHP_REVISION
  
  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c1fcf791b4c1f335ea6200df45663de350ed041857348a20988e9541396c62ef"
    sha256 cellar: :any_skip_relocation, sonoma:        "bf5663406515cce57eb73853b146277cc6494a6cc2b5a6a9c923a56e50cbf441"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ab4ae55eca23dc9a825dc725d9f487a67b7037183700ba781e424a24b25f1b15"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
