require "formula"
require File.expand_path("../../Abstract/abstract-php-version", __FILE__)

class Php74Common < Formula
  desc "PHP Version 7.4 (Common Package)"
  include AbstractPhpVersion::Php74Defs
  version PHP_VERSION
  revision 3

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "php74"
  depends_on "php74-apcu"
  depends_on "php74-gmp"
  depends_on "php74-igbinary"
  depends_on "php74-imagick"
  depends_on "php74-intl"
  depends_on "php74-mcrypt"
  depends_on "php74-mongodb"
  depends_on "php74-opcache"
  depends_on "php74-pdo-pgsql"
  depends_on "php74-redis"
  depends_on "php74-tidy"
  depends_on "php74-xdebug"
  depends_on "php74-xhprof"

  keg_only "this package contains dependency only"

  def install
    system "echo $(date) > installed.txt"
    prefix.install "installed.txt"
  end
end
