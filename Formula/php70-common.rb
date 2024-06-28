require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php70Common < AbstractPhpCommon
  include AbstractPhpVersion::Php70Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.0.33-103"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a0f3846819e32918631ed3faac12b7a4369075fb9deaabdd9a5e474cea09c11e"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
