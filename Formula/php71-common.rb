require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php71Common < AbstractPhpCommon
  include AbstractPhpVersion::Php71Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b9fb2a69c1f97b574de04dedfaf2d8a0f9bd760eb866f8c698f346db0381eb28"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
