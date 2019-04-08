require File.expand_path("../../language/php", __FILE__)

class PhanAT010 < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/phan/phan/archive/0.10.2.tar.gz"
  sha256 "a255427696066bebc440ea792c63a68fc80cbfb6de5d837eaa02fbae03670054"
  head "https://github.com/phan/phan.git"


  keg_only :versioned_formula

  depends_on "php71-ast"
  depends_on "php71"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end
