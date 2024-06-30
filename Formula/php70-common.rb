require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php70Common < AbstractPhpCommon
  include AbstractPhpVersion::Php70Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.0.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ff8dd545e115097f19bc8f54cc102427a6e3d7cd99e635412aa033424c53d017"
    sha256 cellar: :any_skip_relocation, monterey:       "7a1c87b7906cdb5912dfbd6fc315eb71c6d9c2e4aeaccaa82c347be50c5841a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a0f3846819e32918631ed3faac12b7a4369075fb9deaabdd9a5e474cea09c11e"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "5a728c8288b309ec422beb13d4e311e35ee270dc6264a938d8ad3ce3bf611e37"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
