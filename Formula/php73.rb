require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php73 < AbstractPhp
  include AbstractPhpVersion::Php73Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "36e1bd6d75876ba599b8bd2851622a9d7ca23beb5fe2d51e7582ae47c3d278b2"
    sha256 cellar: :any_skip_relocation, ventura:       "da36e477f456fc44bcc320ecfedcda3f1eb2d318eb88a0e3841bfe65e57bac9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ad684d5ad79acf02339965b931bea50e837f57e83c801ccf4799ef334670bc0e"
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
  
  depends_on "libjpeg"

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
