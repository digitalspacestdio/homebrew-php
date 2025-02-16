require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php83Common < AbstractPhpCommon
  include AbstractPhpVersion::Php83Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.16-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8bb0bfeca124ab12dd59f9ec715b2b00757998660c74f6e5a745bad4302cb5b7"
    sha256 cellar: :any_skip_relocation, ventura:       "27fcf14be3849be1b1de477031bc88ecc9dcc836894756e8ab577d25f98cd989"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
