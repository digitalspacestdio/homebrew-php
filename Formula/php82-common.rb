require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php82Common < AbstractPhpCommon
  include AbstractPhpVersion::Php82Defs
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "75cee75ce44865a8203fcf05cb10c591eb47d91da0403321d9b5d05fbcac9697"
    sha256 cellar: :any_skip_relocation, monterey:      "5f612a83270f2c7c7c0b866725cbd5a7e8a3243d532b1450e60917a71ab84015"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "601c1df38bae2f57ae3debe5bf7a686a99bbb6236a4d4d8f122365eb29e73740"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
