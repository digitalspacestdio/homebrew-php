require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php83Common < AbstractPhpCommon
  include AbstractPhpVersion::Php83Defs
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f0c96e5ddb86df9aa50a06e73a9638e93649e3631ada241eacf8a7fb219a8e91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0f1396fcb34c10c5d3d2e13b2efdbbd44a9f9e2157e898b6a80085e1b067c35a"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
