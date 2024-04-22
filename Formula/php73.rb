require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php73 < AbstractPhp
  include AbstractPhpVersion::Php73Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6e99e0a6aaf2287574d24854d5dd103c4e6d369dc62e9f7a6fa30a7d95b597f4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "17115b04c4293a7c1a4bbe7877af1889a21356af78fd580752056b43eaa4e5a9"
    sha256 cellar: :any_skip_relocation, monterey:       "d39e355f1eebb3a6fc68dad7d9913bea58f94fe0c395bcee66a70beb30402511"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "802aa3305d367fa5368c0f7138ed6a298f4762cd0754fa7edd7f77594a671839"
  end
  keg_only :versioned_formula

  def php_version
    "#{PHP_VERSION_MAJOR}"
  end

  def php_version_path
    "#{PHP_BRANCH_NUM}"
  end
  
  depends_on "libjpeg"

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
    log_path var/"log/service-php-#{PHP_VERSION_MAJOR}.log"
    error_log_path var/"log/service-php-#{PHP_VERSION_MAJOR}-error.log"
  end
end
