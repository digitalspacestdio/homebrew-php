require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php70Common < AbstractPhpCommon
  include AbstractPhpVersion::Php70Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-104"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "44311416ab06fe02788fef1f3081eec22f8cfdbd0766e8ba82f318a49310e04c"
    sha256 cellar: :any_skip_relocation, ventura:       "850475833a7bf0a5f0c9376bed955260095d6cb6c9aba3512be77435730cc95d"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
