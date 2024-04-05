require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php73Common < AbstractPhpCommon
  include AbstractPhpVersion::Php73Defs
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ef4a859a1e1eea0153c01dd4a6f281d81dc0d25325b76c105a14c61810f0bfc6"
    sha256 cellar: :any_skip_relocation, sonoma:        "f3a60b2d425ba9f0e5aa328782412c9f9127f492b5e25c2c5b8f3ddc5e1e5683"
    sha256 cellar: :any_skip_relocation, monterey:      "c1e89421cae9477c2ad151c5eb7210738e7ec560bc8fe75042557a0e0ff86411"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eee7f02c33ce7546bb11c06daca51b9c0012b32d2b9ef97446e8819243f73057"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
