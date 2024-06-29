require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php74Common < AbstractPhpCommon
  include AbstractPhpVersion::Php74Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.4.33-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dc8365e388e634480f9b8b2800bf5b32927ab433fb42222fae5816cfb42c97e2"
    sha256 cellar: :any_skip_relocation, monterey:       "161892641f4d09fbb1e3afd0654712274b28355f0a6f53e48ed70d5cafc10ee0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "123f2483349d703c97f486166bb078a493242f495f13332f1ebb4ac6a0298646"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
