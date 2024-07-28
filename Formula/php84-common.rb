require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php84Common < AbstractPhpCommon
  include AbstractPhpVersion::Php84Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0-100"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7be034f50f9169b2778e6ed93f889f1b4750186be33fd3c106524614d335c32c"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "25dfb2e32691997ec1c11dd6e0c148ed963cc69c410e3c056066ca2dd82bf61d"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
