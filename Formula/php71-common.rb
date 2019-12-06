require "formula"
require File.expand_path("../../Abstract/abstract-php-version", __FILE__)

class Php71Common < Formula
  desc "PHP Version 7.1 (Common Package)"
  include AbstractPhpVersion::Php71Defs
  version PHP_VERSION
  revision 2

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "php71"
  depends_on "php71-apcu"
  depends_on "php71-mcrypt"
  depends_on "php71-igbinary"
  depends_on "php71-imagick"
  depends_on "php71-intl"
  depends_on "php71-pdo-pgsql"
  depends_on "php71-mongodb"
  depends_on "php71-redis"
  depends_on "php71-tidy"
  depends_on "php71-gmp"
  depends_on "php71-xhprof"
  depends_on "php71-xdebug"
  depends_on "php71-memprof"

  keg_only "this package contains dependency only"

  def install
    system "echo $(date) > installed.txt"
    prefix.install "installed.txt"
  end
end
