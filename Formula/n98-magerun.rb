require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class N98Magerun < AbstractPhpPhar
  init
  desc "Swiss army knife for Magento developers, sysadmins and devops."
  homepage "http://magerun.net/"
  url "https://files.magerun.net/n98-magerun-1.103.0.phar"
  sha256 "8c96d47c665ea9c9335e57f711662af143c06da7a750faf55bc41303d95b5422"

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
