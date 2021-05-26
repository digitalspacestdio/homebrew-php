require "formula"
require File.expand_path("../../Abstract/abstract-php-version", __FILE__)

class Php74Common < Formula
  desc "PHP Version 7.4 (Common Package)"
  include AbstractPhpVersion::Php74Defs
  version PHP_VERSION
  revision 8

  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on "digitalspacestdio/php/php74"
  depends_on "digitalspacestdio/php/php74-apcu"
  depends_on "digitalspacestdio/php/php74-gmp"
  depends_on "digitalspacestdio/php/php74-igbinary"
  depends_on "digitalspacestdio/php/php74-intl"
  depends_on "digitalspacestdio/php/php74-mcrypt"
  depends_on "digitalspacestdio/php/php74-mongodb"
  depends_on "digitalspacestdio/php/php74-opcache"
  depends_on "digitalspacestdio/php/php74-pdo-pgsql"
  depends_on "digitalspacestdio/php/php74-sodium"
  depends_on "digitalspacestdio/php/php74-redis"
  depends_on "digitalspacestdio/php/php74-tidy"
  depends_on "digitalspacestdio/php/php74-zip"
  depends_on "digitalspacestdio/php/php74-ldap"
  depends_on "digitalspacestdio/php/php74-ioncubeloader"

  keg_only "this package contains dependency only"

#   if OS.mac?
#     system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]' | xargs -I{} printf '{} ' | xargs #{HOMEBREW_PREFIX}/bin/brew unlink"
#   elsif OS.linux?
#     system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]' | xargs -I{} printf '{} ' | xargs --no-run-if-empty #{HOMEBREW_PREFIX}/bin/brew unlink"
#   end

  def install
    system "echo $(date) > installed.txt"
    prefix.install "installed.txt"
  end
end
