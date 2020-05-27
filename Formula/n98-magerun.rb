require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class N98Magerun < AbstractPhpPhar
  init
  desc "Swiss army knife for Magento developers, sysadmins and devops."
  homepage "http://magerun.net/"
  url "https://files.magerun.net/n98-magerun-1.103.3.phar"
  sha256 "c6f41a21e53f9253a59eaa50fc76375a5e1e30898968cc534eb57c0d4ffdeec0"

  bottle :unneeded

  def phar_file
    "n98-magerun-#{version}.phar"
  end

  def phar_bin
    "n98-magerun"
  end

  test do
    system "#{bin}/n98-magerun", "list"
  end
end
