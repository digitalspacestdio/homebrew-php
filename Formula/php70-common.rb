require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php70Common < AbstractPhpCommon
  include AbstractPhpVersion::Php70Defs
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a651dc008bbce5d1b1bb72d4de73f5d55c5e409fe84ea52c1c96cee33f7f76ad"
    sha256 cellar: :any_skip_relocation, sonoma:        "a841ad5cee255f388aa200345dc24f7d8d42b917440154e91feac5ef62cd520d"
    sha256 cellar: :any_skip_relocation, monterey:      "3825be975ffe6cc88e502854f61e1c8726f714e0fc59c9d0db9c6ffe2c2b7898"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ea867908fb124d7059a6475a456e39befa3de43429cd917f9ae49c4ece0979de"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
