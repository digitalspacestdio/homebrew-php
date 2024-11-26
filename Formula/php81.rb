require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php81 < AbstractPhp
  include AbstractPhpVersion::Php81Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ff9f25bc6a98aa68bf6905f6cbdcae4fb342f304b1dd3ac48cb63f2f102d0687"
    sha256 cellar: :any_skip_relocation, ventura:       "a7b551e8fdfffd77c2290130687cc6362a7d43a73d65ed1aeb0401e25829b531"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1350ed6c2c069be33330fc5038f3ecfd3cff1da0a29e54168b6b756cbaa68faf"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "5fafa062796e6c734b06250df13ae89147192d2648678f2ec8d3f35d7b9938b0"
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
    log_path var/"log/service-php-#{PHP_VERSION_MAJOR}.log"
    error_log_path var/"log/service-php-#{PHP_VERSION_MAJOR}-error.log"
  end
end
