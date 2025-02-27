require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  include AbstractPhpVersion::Php70Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "14c035aa429c4aa5afb7912b1496e8a3e51cd4968403e2601ae7af50fe6698ba"
    sha256 cellar: :any_skip_relocation, ventura:       "7cd940c9900dcd3eb5b15a7416dc4dca8352f71ba26047beffb2d7d273a447be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6445c75321bf79e3ede767cb5c37bb18eb3479680eb71aca72944bdc2ebfa91f"
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

  patch do
    url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php70/Fix-Wimplicit-function-declaration_in_configure.patch"
    sha256 "650193d19b0a033c33e9f420bb5a262699cb60d04d363c714858816ed33d281d"
  end

  if OS.mac?
    patch do
      url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php72/macos.patch"
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
