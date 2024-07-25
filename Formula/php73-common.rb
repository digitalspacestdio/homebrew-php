require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php73Common < AbstractPhpCommon
  include AbstractPhpVersion::Php73Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3ca5c45a0c5526f1f45264c858be84f7de8a5befd365b873a0dcef25e24087be"
    sha256 cellar: :any_skip_relocation, monterey:       "b1712e2800bdd33be597993bc836fb1e166d6f428e6a101f0e3a74d6ab038d48"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dfe28c3bcf602bdc99fe363d9413e57bd7fa155b359e3216dab05fbac815c5bf"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "b1eacd63075ec67d728b43dbad18b74434c4d8876357bc8d6e87df22faedb776"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
