require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php70Common < AbstractPhpCommon
  include AbstractPhpVersion::Php70Defs

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70-common"
    sha256 cellar: :any_skip_relocation, sonoma: "a841ad5cee255f388aa200345dc24f7d8d42b917440154e91feac5ef62cd520d"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
