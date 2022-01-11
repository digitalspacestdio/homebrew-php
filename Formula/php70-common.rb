require "formula"
require File.expand_path("../../Abstract/abstract-php-version", __FILE__)

class Php70Common < Formula
  desc "PHP Version 7.1 (Common Package)"
  include AbstractPhpVersion::Php71Defs
  version PHP_VERSION
  revision 6

  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on "digitalspacestdio/php/php70"
  depends_on "digitalspacestdio/php/php70-apcu"
  depends_on "digitalspacestdio/php/php70-gmp"
  depends_on "digitalspacestdio/php/php70-igbinary"
  depends_on "digitalspacestdio/php/php70-intl"
  depends_on "digitalspacestdio/php/php70-mcrypt"
  depends_on "digitalspacestdio/php/php70-mongodb"
  depends_on "digitalspacestdio/php/php70-opcache"
  depends_on "digitalspacestdio/php/php70-pdo-pgsql"
  depends_on "digitalspacestdio/php/php70-sodium"
  depends_on "digitalspacestdio/php/php70-redis"
  depends_on "digitalspacestdio/php/php70-tidy"
  depends_on "digitalspacestdio/php/php70-ldap"
  # depends_on "digitalspacestdio/php/php70-ioncubeloader"

  keg_only "this package contains dependency only"

  def fetch
    if OS.mac?
      system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]$' | xargs -I{} printf '{} ' | xargs #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
    elsif OS.linux?
      system "#{HOMEBREW_PREFIX}/bin/brew list --formula | grep 'php[5-8][0-9]$' | xargs -I{} printf '{} ' | xargs --no-run-if-empty #{HOMEBREW_PREFIX}/bin/brew unlink 1>&2"
    end
  end

  def install
    system "echo $(date) > installed.txt"
    prefix.install "installed.txt"
  end
end
