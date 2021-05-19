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

  if OS.mac?
    patch do
      url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php73/macos.patch"
      sha256 "cf28218565c07b26d0764e903b24421b8095a6bbc68aded050b9fe0cc421729d"
    end
  end
end
