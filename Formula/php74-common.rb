require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php74Common < AbstractPhpCommon
  include AbstractPhpVersion::Php74Defs

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74-common"
    sha256 cellar: :any_skip_relocation, sonoma: "3477b4b03c5684b13226dcf46c7e809becdfbc33fa790178599bbe097be77e4c"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
