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
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "4531422312e9924c4c0e7e6ccac0b2ce0795521a768b604bd4b4a6343e3d914c"
    sha256 cellar: :any_skip_relocation, sonoma:       "5157be152f5c6843915b1dbce713852d8461b458e477816d1a7825cff939557b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "67d9b37416c174bb2beceed3f66ee96a0b0f8b45477f67df81a490f127261a8e"
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
