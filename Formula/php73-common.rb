require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php73Common < AbstractPhpCommon
  include AbstractPhpVersion::Php73Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dfe28c3bcf602bdc99fe363d9413e57bd7fa155b359e3216dab05fbac815c5bf"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
