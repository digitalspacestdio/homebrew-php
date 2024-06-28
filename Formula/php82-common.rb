require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php82Common < AbstractPhpCommon
  include AbstractPhpVersion::Php82Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.2.20-106"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3b2895f1e1ed10a679135f274f8ad603b74ce41674b79b9dc943db51518a55c9"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
