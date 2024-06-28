require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php72Common < AbstractPhpCommon
  include AbstractPhpVersion::Php72Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.2.34-103"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "779dfc99b851834e3fe49c7916796f1df086c5f8642175bcbf1ab2bc8fe66045"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
