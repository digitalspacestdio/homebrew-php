require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php82Common < AbstractPhpCommon
  include AbstractPhpVersion::Php82Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.27-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6c78a099fc67d454ac3a7085d1252539798f3b7c8320608e29dd19c9cf9fc1d6"
    sha256 cellar: :any_skip_relocation, ventura:       "a853105ec61c10bdb73d3b8ac5cb978dd42e9ad7cc8f3a425bb59e86c6857b5f"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
