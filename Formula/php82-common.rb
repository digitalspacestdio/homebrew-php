require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php82Common < AbstractPhpCommon
  include AbstractPhpVersion::Php82Defs

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82-common"
    sha256 cellar: :any_skip_relocation, sonoma: "f7e71c2bbb0c56a3374dd093bbdf2d3b29c16b2dc3a6dfa4865107823b0ee100"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
