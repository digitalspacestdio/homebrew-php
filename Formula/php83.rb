require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php83 < AbstractPhp
  include AbstractPhpVersion::Php83Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.17-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "89be7aa47cbf4851420c156664e411399fe97ee84f493a580c3c0831c45daa80"
    sha256 cellar: :any_skip_relocation, ventura:       "324e9561457641cd74ec874424f61b072a3c30bd1a7e32aa11a0b1bbf3a8c4c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "57f8c2317ae75bcc92431944ea7d5e2e86f1298e8121fe833bda707f4847bd7f"
  end
  
  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]
  head PHP_GITHUB_URL, :branch => PHP_BRANCH
  keg_only :versioned_formula

  def php_version
    "#{PHP_VERSION_MAJOR}"
  end

  def php_version_path
    "#{PHP_BRANCH_NUM}"
  end

  depends_on "pkg-config" => :build
  depends_on "krb5"
  depends_on "oniguruma"
  depends_on "libjpeg"
  depends_on "bison"
  depends_on "re2c" => :build

  def install_args
    args = super
    args << "--with-bison=#{Formula["bison"].opt_prefix}"
    args << "--with-re2c=#{Formula["re2c"].opt_prefix}"
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
    log_path var/"log/service-php-#{PHP_VERSION_MAJOR}.log"
    error_log_path var/"log/service-php-#{PHP_VERSION_MAJOR}-error.log"
  end
end
