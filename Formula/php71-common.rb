require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php71Common < AbstractPhpCommon
  include AbstractPhpVersion::Php71Defs

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71-common"
    sha256 cellar: :any_skip_relocation, sonoma: "bf5663406515cce57eb73853b146277cc6494a6cc2b5a6a9c923a56e50cbf441"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
