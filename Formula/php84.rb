require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php84 < AbstractPhp
  include AbstractPhpVersion::Php84Defs

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.4-111"
    sha256 cellar: :any_skip_relocation, ventura: "f2c859c9ec54d4d4f9f44a7c1e4455cdf2a0f1c34a48bdd3af0e3e29c94f35e0"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION
  head "https://github.com/php/php-src.git", branch: "php-8.4"
  
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
  depends_on "bison" => :build
  depends_on "re2c" => :build

  depends_on "krb5"
  depends_on "oniguruma"
  depends_on "libjpeg"

  if OS.mac?
      patch do
        url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php84/macos.patch"
        sha256 "e8a7f6350103f6aa0dbe9ba6871e813973cfeb489f3594ef46271b0487ac3f65"
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
