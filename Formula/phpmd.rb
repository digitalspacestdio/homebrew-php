require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpmd < AbstractPhpPhar
  init
  desc "PHP Mess Detector"
  homepage "http://phpmd.org"
  url "http://static.phpmd.org/php/2.6.0/phpmd.phar"
  sha256 "69bec1176370a3bcbb81e1d422253f70305432ecf5b2c50d04ec33adb0e20f7a"
  head "https://github.com/phpmd/phpmd.git"


  test do
    system "#{bin}/phpmd", "--version"
  end
end
