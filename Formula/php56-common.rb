require "formula"
require File.expand_path("../../Abstract/abstract-php-version", __FILE__)

class Php56Common < Formula
  desc "PHP Version 5.6 (Common Package)"
  include AbstractPhpVersion::Php56Defs
  version PHP_VERSION
  revision 4

  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on "php56"
  depends_on "php56-apcu"
  depends_on "php56-gmp"
  depends_on "php56-igbinary"
  depends_on "php56-imagick"
  depends_on "php56-intl"
  depends_on "php56-mcrypt"
  depends_on "php56-mongodb"
  depends_on "php56-opcache"
  depends_on "php56-pdo-pgsql"
  depends_on "php56-redis"
  depends_on "php56-tidy"
  depends_on "php56-xdebug"
  depends_on "php56-xhprof"

  keg_only "this package contains dependency only"

  def install
    system "echo $(date) > installed.txt"
    prefix.install "installed.txt"
  end
end
