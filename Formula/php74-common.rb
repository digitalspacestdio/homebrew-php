require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php74Common < AbstractPhpCommon
  include AbstractPhpVersion::Php74Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0b081b525cc25ad72c58d670e91e7bcff178456558a0b2b64311868aecffdfc1"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "b24fa6837fa0b01321ad039b85b3e936e93f9b4b62c34a02349409b46d766c5f"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
