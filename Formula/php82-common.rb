require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php82Common < AbstractPhpCommon
  include AbstractPhpVersion::Php82Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.27-111"
    sha256 cellar: :any_skip_relocation, ventura:      "1f01537c3909b1b27b2d6432cc58f3b01e18751aaf931ec96618a5bed2dddf09"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d291c6cb814f0ca5bfc146295eec3042682c479e4c0b3554e47ed882ac1ce975"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
