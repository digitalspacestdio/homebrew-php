require File.expand_path("../../language/php", __FILE__)

class PhanAT08 < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/etsy/phan/archive/0.8.10.tar.gz"
  sha256 "4e552b0e764613940f32b888a13090a13ae39f35c9391061c70dc04b422c240f"
  head "https://github.com/phan/phan.git"


  keg_only :versioned_formula

  depends_on "php70-ast"
  depends_on "php70"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end
