require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php74 < AbstractPhp
  include AbstractPhpVersion::Php74Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1d1ef941373f1ce4208a09cfc0bc03f2ff14ae0f12ae410e82ca50d78281f0bb"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "af6eedd27491b07d40b685d441cf8a82375f453babbb41e595d77dbc97623fe8"
    sha256 cellar: :any_skip_relocation, monterey:       "6bdc84ebffeb00736e0201338c8a51c34a308fd79267dd6b3b942868c23fea36"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a9971f0922935639287495926cb7933dbe44b2d1ac2f3e8cf726512cac067623"
  end
  
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
