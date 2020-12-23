require "formula"
require File.expand_path("../../Abstract/abstract-php-version", __FILE__)

class Php73Common < Formula
  desc "PHP Version 7.3 (Common Package)"
  include AbstractPhpVersion::Php73Defs
  version PHP_VERSION
  revision 4

  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on "php73"
  depends_on "php73-apcu"
  depends_on "php73-gmp"
  depends_on "php73-igbinary"
  depends_on "php73-imagick"
  depends_on "php73-intl"
  depends_on "php73-mcrypt"
  depends_on "php73-mongodb"
  depends_on "php73-opcache"
  depends_on "php73-pdo-pgsql"
  depends_on "php73-redis"
  depends_on "php73-tidy"
  depends_on "php73-xdebug"
  depends_on "php73-xhprof"

  keg_only "this package contains dependency only"

  def install
    system "echo $(date) > installed.txt"
    prefix.install "installed.txt"
  end
end
