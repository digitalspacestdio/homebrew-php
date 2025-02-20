require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php80Common < AbstractPhpCommon
  include AbstractPhpVersion::Php80Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f70b2b65c535558548044520c25b283fad92c459adf6aa33761500147a9869ff"
    sha256 cellar: :any_skip_relocation, ventura:       "a0b435688e8ff427e37ec01aec45f166697a8376a7e3e5cacddf1be9578b174f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3fc230d3fbf9fc5e25a4bec37cb94a5a0b733a90b548935acaec305e3399ddcb"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
