require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php81Common < AbstractPhpCommon
  include AbstractPhpVersion::Php81Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-111"
    sha256 cellar: :any_skip_relocation, ventura:      "b27aab3f5b954639161c826a7f60837e0381d45b4d71a31e248668f2e6b13f52"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1c8b94455b26deb209ce36f91fe3553b645a71a62440bcbbd35e290aad7ace67"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
