require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpdocumentor < AbstractPhpPhar
  init
  desc "Documentation Generator for PHP"
  homepage "http://www.phpdoc.org"
  url "https://github.com/phpDocumentor/phpDocumentor2/releases/download/v2.9.0/phpDocumentor.phar"
  version "2.9.0"
  sha256 "c7dadb6af3feefd4b000c19f96488d3c46c74187701d6577c1d89953cb479181"



  def phar_file
    "phpDocumentor.phar"
  end

  def phar_bin
    "phpdoc"
  end

  test do
    system "phpdoc", "--version"
  end
end
