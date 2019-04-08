require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  desc "PHP Version 5.6"
  include AbstractPhpVersion::Php56Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 10

  head PHP_GITHUB_URL, :branch => PHP_BRANCH



  def php_version
    "5.6"
  end

  def php_version_path
    "56"
  end

  def patches
    list = super
    if OS.mac?
        [list].compact << "https://gist.githubusercontent.com/sergeycherepanov/1080efdee058292651f658d9e64dee27/raw/48907f18266adc21b23a40d6f35e7d120bcd472a/php56brew.patch"
    else
        list
    end
  end
end
