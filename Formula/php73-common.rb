require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php73Common < AbstractPhpCommon
  include AbstractPhpVersion::Php73Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-111"
    sha256 cellar: :any_skip_relocation, ventura:      "f6befe9e3fac36655d06dbb88728f6e664705d397bb995cabe32c5fcd8f03f41"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b9654105a9bf691357f48e648dc3127c6c86a723b53797699186ff8f4b2df18e"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
