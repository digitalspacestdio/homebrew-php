require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  include AbstractPhpVersion::Php56Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  head PHP_GITHUB_URL, :branch => PHP_BRANCH
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "713a2d1f213639d73badbbdfd5ef8b164236d08871c88e852aeaf36dddd67055"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "16c7915182017441d141cb013ad855fb071bace0f27e2aa67485f2a0459d8265"
    sha256 cellar: :any_skip_relocation, sonoma:        "aa4f19c3eb41dec7aff5260f7d8da2e8afb2a3031ca3aaf4c418745d930589bd"
    sha256 cellar: :any_skip_relocation, monterey:      "b11f5772d18024c53fc007cd8f1e102e418bbd9bcdc3d3b93fe776a535f04f6e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2c8df8f1757fdd8e5124df8a47e17e832b186c8fb1b769cefda1df94195dc377"
  end  

  keg_only :versioned_formula

  def php_version
    "#{PHP_VERSION_MAJOR}"
  end

  def php_version_path
    "#{PHP_BRANCH_NUM}"
  end

  if OS.mac?
    patch do
      url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php#{PHP_BRANCH_NUM}/macos.patch"
      sha256 "f77d653a6f7437266c41de207a02b313d4ee38ad6071a2d5cf6eb6cb678ee99f"
    end
  end

  patch do
    url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php#{PHP_BRANCH_NUM}/LibSSL-1.1-compatibility.patch"
    sha256 "c9715b544ae249c0e76136dfadd9d282237233459694b9e75d0e3e094ab0c993"
  end

  patch do
    url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php#{PHP_BRANCH_NUM}/Make-use-of-pkg-config-for-libxml2.patch"
    sha256 "92d9746508a98b5871a4645b59aa95a364aae63705aa9e184da829eedb6c74a9"
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
