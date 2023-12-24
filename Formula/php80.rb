require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php80 < AbstractPhp
  init
  desc "PHP Version 8"
  include AbstractPhpVersion::Php80Defs
  version PHP_VERSION
  revision 2

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "04ec9b1700c14109f8edb278d14d74ced22157542cea527c7456e96d49434757"
    sha256 cellar: :any_skip_relocation, ventura:       "4510af0f9ca2af1a37b26b38950406acd4b2bf709f5b497367053690d8c9abc0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "87d1d7736e798ca053dc1758e0194e9b2810bd1c465c462676979271d91c65ad"
  end
  keg_only :versioned_formula
  depends_on "pkg-config" => :build
  depends_on "krb5"
  depends_on "oniguruma"
  depends_on "libjpeg"

  include AbstractPhpVersion::Php80Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "8.0"
  end

  def php_version_path
    "80"
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
