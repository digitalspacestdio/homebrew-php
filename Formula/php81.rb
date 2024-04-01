require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php81 < AbstractPhp
  include AbstractPhpVersion::Php81Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6e9e2029951151433aab5cd7ad9b71a44d99bdd7988a6b05095822a20a34744e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5648074bbebb0cef13b82269c22057df91f8f8a74e248243d6aae160924374c9"
    sha256 cellar: :any_skip_relocation, sonoma:        "ce9272fdb745573cf6d31e4d1ef19068e7cb20f765b2b363da6e8ad1e1a60c2d"
    sha256 cellar: :any_skip_relocation, monterey:      "3667d6af95077e4c589ad165212ba1c6148243c67756429b3a87fa407f0acf2a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "884af0fecef02234bd03b2fceb67c1fef5370dfdf0506479ccfd9009e40ad8c7"
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  head PHP_GITHUB_URL, :branch => PHP_BRANCH
  keg_only :versioned_formula

  def php_version
    "#{PHP_VERSION_MAJOR}"
  end

  def php_version_path
    "#{PHP_BRANCH_NUM}"
  end
  
  depends_on "pkg-config" => :build
  depends_on "krb5"
  depends_on "oniguruma"
  depends_on "libjpeg"



  def install_args
    args = super
    if !build.without? "pear"
      args << "--with-pear"
    end
    args << "--enable-gd"
    args
  end

  if OS.mac?
      patch do
        url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php74/macos.patch"
        sha256 "53de4079666daabac28358b8a025e3c60103e5b1230c66860c8e0b7414c0fec1"
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
