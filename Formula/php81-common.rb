require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php81Common < AbstractPhpCommon
  include AbstractPhpVersion::Php81Defs
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0126eb8861aca3d95156d3f18afc497a0d3baf2864a67a40176d00b4467e43d5"
    sha256 cellar: :any_skip_relocation, sonoma:        "f49b8469774a8d19f43bb6f00d86fee65cdc0c021b1d5eee385942b1091fbeaf"
    sha256 cellar: :any_skip_relocation, monterey:      "2d3de2d601adabe45b375dadd1fb742dee1132bc7dfaa08d03b0b3ec0900e4f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8f48c640b3e68b430bdd416d143202a5a81296e175dea88b86cccb5f5e14da9e"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
