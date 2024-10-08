require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php84Common < AbstractPhpCommon
  include AbstractPhpVersion::Php84Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0beta5-100"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "90240e31dccaf7cd335de6a70955fd69a7ae6d11bc75a5029631a2ccae007a8e"
    sha256 cellar: :any_skip_relocation, ventura:        "ef5f6edccf74b1340527cc6640efe9490c88d453caf2c445ba95d33189220480"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6b98184f7607c6efd4ed96de3a1128a2ea0adc633a4b96f220ab9ed7b3c83cfe"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "dc54239a91843c61d112797514c95096f0da445f468d42442c1e5fdfb9a9fa79"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
