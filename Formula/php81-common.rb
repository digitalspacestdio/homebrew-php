require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php81Common < AbstractPhpCommon
  include AbstractPhpVersion::Php81Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, ventura:      "8f480cf4e0352aad4fdaf9ed02ec44f6b00455157474a84adebe31d0f397f198"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e8ce64e85e99e8b10dd2e369a9f2f373d1a01ba9d570c0b551b4c8c600081a4a"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
