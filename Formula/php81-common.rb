require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php81Common < AbstractPhpCommon
  include AbstractPhpVersion::Php81Defs
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f5deadb90c43483d129a08c275714af025990229e325ac27611d8cacacb4d5aa"
    sha256 cellar: :any_skip_relocation, monterey:       "2ebe5658d1103adba158bfdfc58a396b35bd0117a3a583d1ca902cf21d319ff1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "044c0f857246287b9617035a256d219989e603139ae51cc856c5d6cfb19f4a07"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "e4a9be1eecba3f1571f44c77170f7f71579c21e19ff12f4c98c6ad1306d6f498"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
