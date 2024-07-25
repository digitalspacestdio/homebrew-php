require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php82Common < AbstractPhpCommon
  include AbstractPhpVersion::Php82Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c5b8b5c9bfbfdc5e4424e09a35be31756239512a45c04ba85a1e1494f5e92c1b"
    sha256 cellar: :any_skip_relocation, monterey:       "0d7c0e067a66aab8c60dcb5e44fae0c8784fcad9cce0815fea9a824d0ce5ba25"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5796112e43ed0b72c72701e8e6ee2ecea117a33543be89d4876acb68399f7e09"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "d815ad5e0d7d62800910a5dbe71d34b967fac2877f4992b27031d2fe917555ea"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
