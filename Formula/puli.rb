require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Puli < AbstractPhpPhar
  init
  desc "Universal package system for PHP"
  homepage "http://puli.io"
  url "https://github.com/puli/cli/releases/download/1.0.0-beta10/puli.phar"
  version "1.0.0-beta10"
  sha256 "9aa39070480e5faaf61fb8cb92530cf7fc92ed29e3873a0f79448d6812caef3b"


  test do
    system "puli", "--version"
  end
end
