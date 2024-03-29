require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  include AbstractPhpVersion::Php70Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "04bc19cbb806ca9d33da5dd047406b3e2b56da4ce9db29e3477c724ccbd01c43"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7a73d0a6bc99317bc524c90799b88a05d62fa86e8ed3d3eda152e25ed99705c6"
    sha256 cellar: :any_skip_relocation, sonoma:        "8969f978fcff025cf8b8ec411c905b454f95593eebaa2c295317396379739221"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de65c088ab8adf31c2c6471a997c1817d391b4e1d43fb24a781cf4a92a797988"
  end
  keg_only :versioned_formula

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "#{PHP_VERSION_MAJOR}"
  end

  def php_version_path
    "#{PHP_BRANCH_NUM}"
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
