require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php73 < AbstractPhp
  init
  desc "PHP Version 7.3"
  include AbstractPhpVersion::Php73Defs
  version PHP_VERSION
  revision 5

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e3686a8e102cc852ef8e9e13f19c7762609c6cb3fecadcc3821c750c48a67bc2"
    sha256 cellar: :any_skip_relocation, ventura:       "2df62b82439bd6189c57f7c2fd2dc9b97238d310232dba004e50557653281089"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e00422bede1bba600597e01627eb5da20d9ec99dd892334e19416f3288fe28cf"
  end
  keg_only :versioned_formula
  depends_on "libjpeg"

  include AbstractPhpVersion::Php73Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.3"
  end

  def php_version_path
    "73"
  end

  def install_args
    args = super
    if !build.without? "pear"
    args << "--with-pear"
    end
    args
  end

  if OS.mac?
    patch do
      url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php73/macos.patch"
      sha256 "cf28218565c07b26d0764e903b24421b8095a6bbc68aded050b9fe0cc421729d"
    end
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
