require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php83Common < AbstractPhpCommon
  include AbstractPhpVersion::Php83Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.8-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "de658ab7a98719bae12a7b5e7bf01fd1f4f342631408c03a2576a2f3d38f75e4"
    sha256 cellar: :any_skip_relocation, monterey:       "fd6efd35742620e325e45c0e926163e97d7aaea02765ae7f2495e0bf70aa7d1d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "19a03879674b6a75d20189bb86e29f86e85ee7f62b98b95e5f2817496ee660c8"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "a0a6ee38592318984ee4e424fa3503ef0486b0660ce0da5af2e392bec06020ee"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
