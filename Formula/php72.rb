require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php72 < AbstractPhp
  include AbstractPhpVersion::Php72Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "11f083907c60bc691d9e3b02ed66216a473fc339574e15e60117dc8a7f96fac7"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e0ed040d4a418103b35aeee6bfe04350e68e3c8268f6a1d49450db4f8efce7f6"
    sha256 cellar: :any_skip_relocation, sonoma:        "31c0f879deb642582e7c49162cb7252993c3412a8427408fdcdab6849005e2be"
    sha256 cellar: :any_skip_relocation, monterey:      "1b777c73344ea280ad832140bd1fc51427f730c09329b7cb34f5806a6522b461"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c49ba67e24c48c4f2fe12e3dcf797051bee2bdd6d3ccca5ee527716a8d95955"
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
