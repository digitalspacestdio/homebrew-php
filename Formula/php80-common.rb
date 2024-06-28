require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php80Common < AbstractPhpCommon
  include AbstractPhpVersion::Php80Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5ad13cb46a002b27f412b27782406f2d5884a6747f0dee84bd6de2858b983d6e"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
