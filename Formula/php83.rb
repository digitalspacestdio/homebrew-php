require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php83 < AbstractPhp
  init
  desc "PHP Version 8.3"
  include AbstractPhpVersion::Php83Defs
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles"
    rebuild 1
    sha256 arm64_ventura: "9777f38d588d1f65a441a52b5e18ef14a533278ba6546e985af8472877e8111e"
  end
  keg_only :versioned_formula
  depends_on "pkg-config" => :build
  depends_on "krb5"
  depends_on "oniguruma"
  depends_on "libjpeg"
  depends_on "bison"
  depends_on "re2c"

  include AbstractPhpVersion::Php83Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "#{PHP_VERSION_MAJOR}"
  end

  def php_version_path
    "#{PHP_BRANCH_NUM}"
  end

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
end
