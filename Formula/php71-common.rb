require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php71Common < AbstractPhpCommon
  include AbstractPhpVersion::Php71Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c03ce5f63948c4a9d458e9768a6af689eb3466a4307a821cc9332b0091f78f4c"
    sha256 cellar: :any_skip_relocation, monterey:       "4294d34f72fbcbc5e9859b229de0d212cf38a8240c9adabcf1f7b7238f921473"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b9fb2a69c1f97b574de04dedfaf2d8a0f9bd760eb866f8c698f346db0381eb28"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "848c51e29549da9e25756c38a6a56133d5df3adac316f96caf2e5b929be30787"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
