require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php73 < AbstractPhp
  include AbstractPhpVersion::Php73Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1b7e163f1262322678e6ea09fd1c83000a40c3c608be54cde8d677ac90b4698c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cfe01b8b9bdd07427fdb840a0fc8754baea979c41423a80db20d26f3bd2ada0a"
    sha256 cellar: :any_skip_relocation, sonoma:        "611580bdb2b8720ac9a6b5154d0fd52af73f33c112ac8b59bf5e3f5ed8519f56"
    sha256 cellar: :any_skip_relocation, monterey:      "3b4d61bb117e733271b127c2bb9a48d5b1ebbe8221cd3ce1fa1a19aa1765e9c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "601771f06432d88a85afc8636cc9ed067be627f25c32e391c560712cf0479246"
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
