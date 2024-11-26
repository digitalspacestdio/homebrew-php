require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php82Common < AbstractPhpCommon
  include AbstractPhpVersion::Php82Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.26-106"
    sha256 cellar: :any_skip_relocation, ventura:       "4e11e5d96bbdc668ee76ece7a89dddb1391039b3fee60ece57f7be0034ac20cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "25629933d6d97c67efd3a03c394a0444ab3659c5075413f8dd28f3cb110a5965"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "8666ef235a8b425e39ed26d6facbaf62cdee96a4193e2ba7dfce6a84e6820a53"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
