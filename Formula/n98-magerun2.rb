require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class N98Magerun2 < AbstractPhpPhar
  init
  desc "Swiss army knife for Magento 2 developers, sysadmins and devops."
  homepage "http://magerun.net/"
  url "https://files.magerun.net/n98-magerun2-4.1.0.phar"
  sha256 "00d4b68e9e37fd3b452ed591c7891bdaff8c3881873c90883f9e49029c404165"

  bottle :unneeded

  def phar_file
    "n98-magerun2-#{version}.phar"
  end

  def phar_bin
    "n98-magerun2"
  end

  test do
    system "#{bin}/n98-magerun2", "list"
  end
end
