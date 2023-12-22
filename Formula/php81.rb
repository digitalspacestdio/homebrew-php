require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php81 < AbstractPhp
  init
  desc "PHP Version 8.1"
  include AbstractPhpVersion::Php81Defs
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9545f7937f9135308035de6cc9d6f211df69d7702e221b370be2c79e1504d1d9"
    sha256 cellar: :any_skip_relocation, ventura:       "047da4ee42d7c0d917ba333732b34b25057e2a4cb2c1b2b3e3ce97569c0019f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "854c795a04a774de86342a0ff900119ca1badc0fb1a2066597de24cf721fe86c"
  end
  keg_only :versioned_formula
  depends_on "pkg-config" => :build
  depends_on "krb5"
  depends_on "oniguruma"
  depends_on "libjpeg"

  include AbstractPhpVersion::Php81Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "8.1"
  end

  def php_version_path
    "81"
  end

  def install_args
    args = super
    if !build.without? "pear"
      args << "--with-pear"
    end
    args << "--enable-gd"
    args
  end

  if OS.mac?
      patch do
        url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php74/macos.patch"
        sha256 "53de4079666daabac28358b8a025e3c60103e5b1230c66860c8e0b7414c0fec1"
      end
  end

  service do
    name macos: "php#{PHP_VERSION_MAJOR}-fpm", linux: "php#{PHP_VERSION_MAJOR}-fpm"
    run [opt_sbin/"php-fpm", "--nodaemonize", "--fpm-config", "#{etc}/php/#{PHP_VERSION_MAJOR}/php-fpm.conf"]
    working_dir HOMEBREW_PREFIX
    keep_alive true
    require_root false
    log_path var/"log/php-#{PHP_VERSION_MAJOR}/service.log"
    error_log_path var/"log/php-#{PHP_VERSION_MAJOR}/service-error.log"
  end
end
