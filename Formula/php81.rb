require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php81 < AbstractPhp
  init
  desc "PHP Version 8.1"
  include AbstractPhpVersion::Php81Defs
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles"
    rebuild 1
    sha256 arm64_ventura: "660dc7600c2a173a2432881b28deede79c4eae33b5231f8d34d1f61082c22fe1"
  end
  keg_only :versioned_formula
  depends_on "pkg-config" => :build
  depends_on "krb5"
  depends_on "oniguruma"
  depends_on "libjpeg"

  include AbstractPhpVersion::Php81Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "8.1"
  end

  def php_version_path
    "81"
  end

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
end
