require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php56Common < AbstractPhpCommon
  include AbstractPhpVersion::Php56Defs
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "28dd2ab6311da4b1368ab6862e3d0ca5b560cdfde6cc3285b7920695e1645e34"
    sha256 cellar: :any_skip_relocation, monterey:      "f57c000865db86afd4265075250e080b5e9732fb6fde6225fb1a614e491341db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ccf4e06af2d497f945f8f051f846b472a52118ac8bebb12d8ac7b35ed670f6e2"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
