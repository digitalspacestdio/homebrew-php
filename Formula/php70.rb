require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  include AbstractPhpVersion::Php70Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  head PHP_GITHUB_URL, :branch => PHP_BRANCH
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ef312563ae9f0a63c5395a8f0ba85be5b9453fc33a6ba804d24b7f1c2c38ee57"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "20c356baff68735e7e9ea8d44bf79e76db498dfce173ae8428e7f0c0baedba09"
    sha256 cellar: :any_skip_relocation, sonoma:        "bc8bb4a346216c5539d510072cd2736261075a0a5da851d97f9f90d16275c7ae"
    sha256 cellar: :any_skip_relocation, monterey:      "a9693df9b64cdc76463e531ce6645587a6d3e92214c27a298e0506e03601a22e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "32b0483d1d4e9e1d73a442555a9ac62283ef98ab8f52808b0b70598f2b39b09f"
  end

  keg_only :versioned_formula

  def php_version
    "#{PHP_VERSION_MAJOR}"
  end

  def php_version_path
    "#{PHP_BRANCH_NUM}"
  end

  patch do
    url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/icufix/Patches/php70/Fix-Wimplicit-function-declaration_in_configure.patch"
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
