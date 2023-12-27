require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php73 < AbstractPhp
  init
  desc "PHP Version 7.3"
  include AbstractPhpVersion::Php73Defs
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bb2727578c878b3162b27d7cb636c5b22672d8c0b0c89cfdc8c986b43e28998a"
    sha256 cellar: :any_skip_relocation, sonoma:        "964605761822bd91d9bcc1a8d2e212274181bb7c1f0ec116a3300d1211445ef0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "328bda8fb809eb904564b68de12a7f130c6b87206e7a0aa29057772a9517ed22"
  end
  keg_only :versioned_formula
  depends_on "libjpeg"

  include AbstractPhpVersion::Php73Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "#{PHP_VERSION_MAJOR}"
  end

  def php_version_path
    "#{PHP_BRANCH_NUM}"
  end

  def install_args
    args = super
    if !build.without? "pear"
    args << "--with-pear"
    end
    args
  end

  if OS.mac?
    patch do
      url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php73/macos.patch"
      sha256 "cf28218565c07b26d0764e903b24421b8095a6bbc68aded050b9fe0cc421729d"
    end
  end

  service do
    name macos: "php#{PHP_VERSION_MAJOR}-fpm", linux: "php#{PHP_VERSION_MAJOR}-fpm"
    run [opt_sbin/"php-fpm", "--nodaemonize", "--fpm-config", "#{etc}/php/#{PHP_VERSION_MAJOR}/php-fpm.conf"]
    working_dir HOMEBREW_PREFIX
    keep_alive true
    require_root false
    log_path var/"log/service-php-#{PHP_VERSION_MAJOR}.log"
    error_log_path var/"log/service-php-#{PHP_VERSION_MAJOR}-error.log"
  end
end
