require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  init
  desc "PHP Version 5.6"
  include AbstractPhpVersion::Php56Defs
  version PHP_VERSION
  revision 11
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH


  def php_version
    "5.6"
  end

  def php_version_path
    "56"
  end

  def openssl_formula_name
    "openssl@1.0"
  end

  def patches
    list = super
    if OS.mac?
        [list].compact << "https://raw.githubusercontent.com/djocker/homebrew-php/master/Patches/php56/macos.patch"
    else
        list
    end
  end
end
