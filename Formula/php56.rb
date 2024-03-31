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
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d7c885e7c64dabf72513090c580f254a5803360ef729a2a9fb3de1dceefbe48a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1af7b8b872a4e31a00b1a1cce531ef15ac3c0f7e693945c682feae14c60fde89"
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
