require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php71Common < AbstractPhpCommon
  include AbstractPhpVersion::Php71Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-111"
    sha256 cellar: :any_skip_relocation, ventura:      "d510a73e22c8d142ed109912b486358d50f9cc73d313087716d16d2f9f88400a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f74a5c2534f138323b33b26f07ba1ae8ce6881d77913dabf1b6ebf142ae7f810"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
