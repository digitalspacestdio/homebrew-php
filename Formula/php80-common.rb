require "formula"
require File.expand_path("../../Abstract/abstract-php-version", __FILE__)

class Php80Common < Formula
  desc "PHP Version 8.0 (Common Package)"
  include AbstractPhpVersion::Php80Defs
  version PHP_VERSION
  revision 1

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "php80"
  depends_on "php80-apcu"
  depends_on "php80-igbinary"
  #depends_on "php80-imagick"
  depends_on "php80-intl"
  depends_on "php80-pdo-pgsql"
  depends_on "php80-mongodb"
  depends_on "php80-redis"
  depends_on "php80-tidy"
  depends_on "php80-gmp"
  depends_on "php80-xdebug"

  keg_only "this package contains dependency only"

  def install
    system "echo $(date) > installed.txt"
    prefix.install "installed.txt"
  end
end
