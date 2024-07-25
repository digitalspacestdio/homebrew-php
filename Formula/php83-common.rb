require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php83Common < AbstractPhpCommon
  include AbstractPhpVersion::Php83Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.9-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "35d6034c7bae72e65dda6d694ac518c5f2d7e9ae9e96ecc3c10bd5f9eca67362"
    sha256 cellar: :any_skip_relocation, monterey:       "82adc130cc2532672baa9215f71c32d73fc16ce32ee1b60bd2f700e3736c82c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ae9e2d083269d0a62f09c42a7ad8657755764a2a479eed2f8b64c9653574d07c"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "c3512e3a2c782552b5de5b0f5a3d6c7fbb954b66d93e0456fe1d7cdb90c7ee6a"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
