require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpctags < AbstractPhpPhar
  init
  desc "Ctags compatible index generator written in pure PHP"
  homepage "https://github.com/vim-php/phpctags"
  url "https://github.com/vim-php/phpctags/archive/0.6.0.tar.gz"
  sha256 "ed9ddbb56f672673274de7ef066071e703b5090d47c9ccc31442dd43b5775190"


  def install
    system "make"
    File.rename("build/phpctags.phar", "build/phpctags")
    bin.install "build/phpctags"
  end

  test do
    system "phpctags", "--version"
  end
end
