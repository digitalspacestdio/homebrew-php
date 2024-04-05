require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php83Common < AbstractPhpCommon
  include AbstractPhpVersion::Php83Defs
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3e1426480bd6484386c8506a8d63ddbe0fa378d1052cb114d27c94eaac26c33e"
    sha256 cellar: :any_skip_relocation, monterey:      "d698a435c56e964e130abd708afc1b7b9a9f559951aef2aea03dd4de4eb442c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0f6b0c148dce52f19a4c4877ed3be158389fe3d65427a91bf7924e3fcf4cc0db"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
