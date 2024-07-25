require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php82Common < AbstractPhpCommon
  include AbstractPhpVersion::Php82Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.20-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f235d2f9c42120f0645de87c331504086ded204f3b2794c4b8121f009e965418"
    sha256 cellar: :any_skip_relocation, monterey:       "e11cfd7a58ae70d03a8df2ae80cb8232a0d7a23a8db7deb8de955b3ddf3bf0e1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3b2895f1e1ed10a679135f274f8ad603b74ce41674b79b9dc943db51518a55c9"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "9b2bb0e575449f7aed038df365c77f22a80aa909de2c968a3a58a85344e7515f"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
