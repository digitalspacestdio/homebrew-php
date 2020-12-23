require "formula"
require File.expand_path("../../Abstract/abstract-php-version", __FILE__)

class Php72Common < Formula
  desc "PHP Version 7.2 (Common Package)"
  include AbstractPhpVersion::Php72Defs
  version PHP_VERSION
  revision 4

  depends_on "php72"
  depends_on "php72-apcu"
  depends_on "php72-gmp"
  depends_on "php72-igbinary"
  depends_on "php72-imagick"
  depends_on "php72-intl"
  depends_on "php72-mcrypt"
  depends_on "php72-mongodb"
  depends_on "php72-opcache"
  depends_on "php72-pdo-pgsql"
  depends_on "php72-redis"
  depends_on "php72-tidy"
  depends_on "php72-xdebug"
  depends_on "php72-xhprof"

  keg_only "this package contains dependency only"

  def install
    system "echo $(date) > installed.txt"
    prefix.install "installed.txt"
  end
end
