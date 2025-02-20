require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php74Common < AbstractPhpCommon
  include AbstractPhpVersion::Php74Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "742d5eb91e61928cd91841d47d9f3be58eb3b9e2583afb6e71d7cbb3f716c9d4"
    sha256 cellar: :any_skip_relocation, ventura:       "5d20f7b291b8d2cd032eb15346c0d2e4d7f083c233f69dac8103a595aaf0dec3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "93c55ce04dd679a4bf86943479bc284e26066633523d277eb9e508b79c086069"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
