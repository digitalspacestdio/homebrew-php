require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php80 < AbstractPhp
  init
  desc "PHP Version 8"
  include AbstractPhpVersion::Php80Defs
  version PHP_VERSION
  revision 2

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles"
    rebuild 1
    sha256 arm64_ventura: "af3ce21c9ef2651913c38b20b73161d0c04b464403b1092875578bffe7c3c285"
  end
  keg_only :versioned_formula
  depends_on "pkg-config" => :build
  depends_on "krb5"
  depends_on "oniguruma"
  depends_on "libjpeg"

  include AbstractPhpVersion::Php80Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "8.0"
  end

  def php_version_path
    "80"
  end

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
end
