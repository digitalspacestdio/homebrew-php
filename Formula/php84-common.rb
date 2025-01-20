require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php84Common < AbstractPhpCommon
  include AbstractPhpVersion::Php84Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.3-106"
    sha256 cellar: :any_skip_relocation, ventura: "74caf71cddc22c334088339d5b55be65ef19eadd1120139742a02276778237cb"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
