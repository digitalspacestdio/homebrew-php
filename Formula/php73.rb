require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php73 < AbstractPhp
  init
  desc "PHP Version 7.3"
  include AbstractPhpVersion::Php73Defs
  version PHP_VERSION
  revision 1

  include AbstractPhpVersion::Php73Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.3"
  end

  def php_version_path
    "73"
  end

  def patches
    list = super
    if OS.mac?
        [list].compact << "https://raw.githubusercontent.com/djocker/homebrew-php/master/Patches/php73/macos.patch"
    else
        list
    end
  end
end
