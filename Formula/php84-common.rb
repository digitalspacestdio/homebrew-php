require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php84Common < AbstractPhpCommon
  include AbstractPhpVersion::Php84Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0beta3-100"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2335c95e362793cd5d5f78d123f4f2ce3bf81c9854ff7aeff33f49d92d5a2821"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
