require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpcpd < AbstractPhpPhar
  init
  desc "Copy/Paste Detector (CPD) for PHP code"
  homepage "https://github.com/sebastianbergmann/phpcpd"
  url "https://phar.phpunit.de/phpcpd-4.0.0.phar"
  sha256 "e406841a9839179953998b3b1d2c3db848920c194c7204f3e603d7aead98bab9"



  def phar_file
    "phpcpd-#{version}.phar"
  end

  test do
    system "#{bin}/phpcpd", "--version"
  end
end
