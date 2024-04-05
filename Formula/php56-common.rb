require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php56Common < AbstractPhpCommon
  include AbstractPhpVersion::Php56Defs
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56-common"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d4184143a57c444c7b7e83e999f55ab3f49c32f7a07ed1f062a2321d7da159f3"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
