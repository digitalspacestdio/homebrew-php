require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Behat < AbstractPhpPhar
  init
  desc "BDD framework for PHP to help you test business expectations"
  homepage "http://behat.org/"
  url "https://github.com/Behat/Behat/releases/download/v3.3.0/behat.phar"
  version "3.3.0"
  sha256 "d99fdf7e7d9459903ae2f9628e0459ab3357a1c93e0b55ad32f60e625c3cb9f7"
  head "https://github.com/Behat/Behat.git"



  test do
    system bin/"behat", "--version"
  end
end
