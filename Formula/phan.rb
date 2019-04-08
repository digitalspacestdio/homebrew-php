require File.expand_path("../../language/php", __FILE__)

class Phan < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/phan/phan/archive/0.11.1.tar.gz"
  sha256 "7a7da34b06db4232e959573375867171b266c59ef54b93276b19e48c360a2b82"
  head "https://github.com/phan/phan.git"

s_on "php72-ast"
  depends_on "php72"

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
