require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php71Common < AbstractPhpCommon
  include AbstractPhpVersion::Php71Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c03ce5f63948c4a9d458e9768a6af689eb3466a4307a821cc9332b0091f78f4c"
    sha256 cellar: :any_skip_relocation, monterey:       "4294d34f72fbcbc5e9859b229de0d212cf38a8240c9adabcf1f7b7238f921473"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b9fb2a69c1f97b574de04dedfaf2d8a0f9bd760eb866f8c698f346db0381eb28"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
