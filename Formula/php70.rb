require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  include AbstractPhpVersion::Php70Defs
  version PHP_VERSION
  revision 23

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4eb49f9954ffefce1d42ad4772d673e4c8eb91013783af4b4be3b64fd40b960d"
    sha256 cellar: :any_skip_relocation, ventura:       "925dffa6c0f63773595bd2ba9b4e5ae257793999a3d65ac566ffd534c4823154"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6298a39d9b1fbc665566988f86931bd008996e7506628ea3865f342df8b51919"
  end
  keg_only :versioned_formula
  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.0"
  end

  def php_version_path
    "70"
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
