require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php84Common < AbstractPhpCommon
  include AbstractPhpVersion::Php84Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0beta3-100"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "78b846076928e79133b55ceab2fd2b384cba371a9ef3cfc480f0c1149e07fe89"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
