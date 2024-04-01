require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php83 < AbstractPhp
  include AbstractPhpVersion::Php83Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a1b13a32803f84d9e8984acd0731b8ee1b14ed246b5bb6e60f4847812ad0fb29"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0ee03e1e952930f6d04da474775d6740b891da91fc5a7c563b68e68e8c77ca81"
    sha256 cellar: :any_skip_relocation, sonoma:        "0ec12617d6d53ab9a2a4b862f20562785e649911949ba03aade88292095b2aaa"
    sha256 cellar: :any_skip_relocation, monterey:      "c0f6facc28ea53869999726c1403cb8af5d0792435eb5f1b85ff1de7c0648b4f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3295b7fbbf7b6e8a7ca6c64e3e8b680d2fc6a0a593b4cf0b6d980ccbd48ef3f9"
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
