require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php72Common < AbstractPhpCommon
  include AbstractPhpVersion::Php72Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-104"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bb8ae24f5eb7933cd19173421655af53a8ce9bf60fa849a2c43baed10e19e093"
    sha256 cellar: :any_skip_relocation, ventura:       "4241ca51a0e11f33b773d1f1de3b417fd7dbd8d7d480e3c91cd52e813c57b84b"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
