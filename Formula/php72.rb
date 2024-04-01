require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  include AbstractPhpVersion::Php72Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3ec1ca7eb8dfdd60fcd77b16539ce39bda1dfc97a649eb11cb86418b9a4c8ad2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e8fb44265105b31695b618bda91fb9f23155f211aaff86a2a781a241845ecbdf"
    sha256 cellar: :any_skip_relocation, sonoma:        "936bc5a29e14c864204c89e3bb695ec4d79f86865b87b512bb4715567954e139"
    sha256 cellar: :any_skip_relocation, monterey:      "1b777c73344ea280ad832140bd1fc51427f730c09329b7cb34f5806a6522b461"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b0bf0970eae57e32194384d3b85c736cfdf4288091afa97b46a5481e22e0adb8"
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
