require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php56Common < AbstractPhpCommon
  include AbstractPhpVersion::Php56Defs
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56-common"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fd8c4cbfab681cec33e11c121ececd807d7651f4e1bfe5bb880c584e6ed5f25b"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
