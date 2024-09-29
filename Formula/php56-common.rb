require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php56Common < AbstractPhpCommon
  include AbstractPhpVersion::Php56Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/5.6.40-104"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8d7824a0f1f7b6ac1c07cc4a28d140c1709e845f24c8ccaffbdda37e18a365f7"
    sha256 cellar: :any_skip_relocation, ventura:       "aa318b20bbf1278b597f610de5901c2de9c440df70d8ec536e95dd2b7dffc3b0"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "6faf348a3f5fe2bc461ccc0e02b4319f8833c979b999337ea2424ccfa3cba9db"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
