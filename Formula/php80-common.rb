require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php80Common < AbstractPhpCommon
  include AbstractPhpVersion::Php80Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bf32c93166e48f46f6b2cc2eec897d59c58b88aa583f48f79987ace97dbd620e"
    sha256 cellar: :any_skip_relocation, monterey:       "2af63dda0082cd231381b539d39664dd6b840e188b0b35b2d2e9a2eac4cb550b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5ad13cb46a002b27f412b27782406f2d5884a6747f0dee84bd6de2858b983d6e"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "7f20c92c02d74a74cdf45dbcb58a8436502ba9ff297df6dd42316b9299b34bd8"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
