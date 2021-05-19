require File.expand_path("../../language/php", __FILE__)

class Phan < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/phan/phan/archive/2.2.7.tar.gz"
  sha256 "29fa77f832b97a41045ef37a462c8fcdf5b77242f31269867c94369b428b338a"
  head "https://github.com/phan/phan.git"


  depends_on "digitalspacestdio/php/php72-ast"
  depends_on "digitalspacestdio/php/php72"

  conflicts_with "phan@0.10", :because => "it provivides a phan binary"
  conflicts_with "phan@0.8", :because => "it provivides a phan binary"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end
