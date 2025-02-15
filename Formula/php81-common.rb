require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php81Common < AbstractPhpCommon
  include AbstractPhpVersion::Php81Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b64400558221687d882953b22002ea74d26895e5748ccb101497eba99be3fe15"
    sha256 cellar: :any_skip_relocation, ventura:       "bfc4d94618360e03cb59b84e4c8433039ccb26ece3bb65b75545c5f525ad83a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e8ce64e85e99e8b10dd2e369a9f2f373d1a01ba9d570c0b551b4c8c600081a4a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "259234c50e5a8efdb64803665c64aaa63015839b7c23b39c1a3a76223ff4fcf0"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
