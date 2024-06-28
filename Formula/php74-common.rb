require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php74Common < AbstractPhpCommon
  include AbstractPhpVersion::Php74Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.4.33-104"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "123f2483349d703c97f486166bb078a493242f495f13332f1ebb4ac6a0298646"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
