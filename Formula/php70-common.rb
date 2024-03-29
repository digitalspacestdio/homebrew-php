require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php70Common < AbstractPhpCommon
  include AbstractPhpVersion::Php70Defs
  revision PHP_REVISION
  
  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7000bfb7239e3a80a0d9233042bd1068de522956b3ec06fd6f54d771e8726130"
    sha256 cellar: :any_skip_relocation, sonoma:        "a841ad5cee255f388aa200345dc24f7d8d42b917440154e91feac5ef62cd520d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "72e6776d7dad0c0ba83f7d680fb96ba2455f96bfb93924c9114b6847f7ad06fb"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
