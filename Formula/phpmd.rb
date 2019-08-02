require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpmd < AbstractPhpPhar
  init
  desc "PHP Mess Detector"
  homepage "http://phpmd.org"
  url "https://github.com/phpmd/phpmd/releases/download/2.6.1/phpmd.phar"
  sha256 "c09b188a7b0a86b42ddc11bd73292ba5aafd4ffbc868466dba325acae3e58b2a"
  head "https://github.com/phpmd/phpmd.git"
  revision 1


  test do
    system "#{bin}/phpmd", "--version"
  end
end
