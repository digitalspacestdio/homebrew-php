require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  include AbstractPhpVersion::Php72Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a69d5e77562a217be7426b5a0fc14a1a5d96d0603a239457a1546c2e3ef4500e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "614e3c2daff5608fbfa0c8a171061423e38ccc46f477869b82243763b680fc01"
    sha256 cellar: :any_skip_relocation, monterey:       "c5da363403a1ff9b96281765dd0f8b95b433ca7be7a62bf23ed45ffa79f8c1d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "069d638b5af919274b2b414e1b0e82ba983496d0b05ece05d2314a86d909b888"
  end
  
  depends_on "libjpeg"

  keg_only :versioned_formula

  def php_version
    "#{PHP_VERSION_MAJOR}"
  end

  def php_version_path
    "#{PHP_BRANCH_NUM}"
  end
  
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def install_args
    args = super
    if !build.without? "pear"
      args << "--with-pear"
    end
    args
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
