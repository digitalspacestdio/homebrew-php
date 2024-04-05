require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php80Common < AbstractPhpCommon
  include AbstractPhpVersion::Php80Defs
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c93133decd95fca26293f1aed8cab4ec9de423f932074446121e738fb30c66d1"
    sha256 cellar: :any_skip_relocation, sonoma:        "d7d03e36cadf3acd5396216bb9569a6c9b533a4f4231e915619db29a7d76c845"
    sha256 cellar: :any_skip_relocation, monterey:      "5b744c2437a72d1d3cb31f415f0c274af639f00311a1fccb8fc1ea98fbfc166b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7f36fdc13abcc5c16c506f46ae7152ae0029e7dfb869641aa5f890828eb2274f"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
