require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php82 < AbstractPhp
  include AbstractPhpVersion::Php82Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.20-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6d8850a753a238f036cabe0e119ab52966149730b2394714100283fe9ad0771c"
    sha256 cellar: :any_skip_relocation, monterey:       "889e5018f34ddefa56fac51ebb63fdecf80b08e04dc35cc1b3183091ea0624b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3b6c45200fbf98ba634d4bb07ab2f9195b16fed610fb1efeff3a14490c258513"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "a2966065a53f3ec0ad7e41115b29a91c91f8f9658bd3a156153ffab4aa79aa32"
  end
  
  url PHP_SRC_TARBALL
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

  def install_args
    args = super
    if !build.without? "pear"
      args << "--with-pear"
    end
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
