require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  include AbstractPhpVersion::Php71Defs
  version PHP_VERSION
  revision 32

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bf1bf0f506a5ed55ecf76524486fd25ba021e8a812bb20df37091a6bfcdef1cd"
    sha256 cellar: :any_skip_relocation, sonoma:        "df28ec13fca0b80d850616155ccd9a639a368313b57689cb1a36c7517225ef82"
    sha256 cellar: :any_skip_relocation, ventura:       "a7536bf803731178521e4cd1f5d98b7be742149a90055be1e2f82db64c8d0057"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d3353adf20dc0f895f616cfe1dea2e71cc14b45cbf065f9c1e10765f614c6a20"
  end
  keg_only :versioned_formula
  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "#{PHP_VERSION_MAJOR}"
  end

  def php_version_path
    "#{PHP_BRANCH_NUM}"
  end

  def config_path
    etc + "php" + php_version
  end

  service do
    run [opt_sbin/"php-fpm", "--nodaemonize", "--fpm-config", etc + "php/7.1/php-fpm.conf"]
    keep_alive true
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
