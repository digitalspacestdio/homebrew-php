require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php72Common < AbstractPhpCommon
  include AbstractPhpVersion::Php72Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "edac2a1be4d5f82a40bf7d50c6594fd75cd776b003971a1ce7b7e21c87e0fa6e"
    sha256 cellar: :any_skip_relocation, ventura:       "683e7c815498f285d787978f9897d90c8ccf9ab3a5c6494c94196dabb4452ce9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e9066e5b97c8f93f76dde17f3e449db73329ef697ef9842f33c1361a7487c69c"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
