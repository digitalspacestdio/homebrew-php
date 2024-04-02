require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php83 < AbstractPhp
  include AbstractPhpVersion::Php83Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e9ab0b81467e7188f1c41262cbd2d3be828d87af4997f0ac08b34ffc5730f78b"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "314766204c47b5e4c05742270abf620ad2a32e143b678a1eabb1f91e21257f2d"
    sha256 cellar: :any_skip_relocation, sonoma:        "a5b9449e1b4ae566c77c6d4006a70d34abe1c2d36abe29f42e3ad892fd3c5062"
    sha256 cellar: :any_skip_relocation, monterey:      "c0f6facc28ea53869999726c1403cb8af5d0792435eb5f1b85ff1de7c0648b4f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e4e961e3142111724586663265e7ce5633ce0b6e56918d751462d57a96ec4d60"
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
  depends_on "bison"
  depends_on "re2c"

  def install_args
    args = super
    if !build.without? "pear"
      args << "--with-pear"
    end
    args << "--with-bison=#{Formula["bison"].opt_prefix}"
    args << "--with-re2c=#{Formula["re2c"].opt_prefix}"
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
