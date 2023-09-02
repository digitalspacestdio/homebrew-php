require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php74 < AbstractPhp
  init
  desc "PHP Version 7.4"
  include AbstractPhpVersion::Php74Defs
  version PHP_VERSION
  revision 4

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cb68f320cb723a387fa2c9faff780051e19ce1bc3251ed1b301a3dd62c3c8209"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "931baadf698fce59a5ffd1212753905c4304c1de4d5502171ceebdc3a59403fd"
  end
  keg_only :versioned_formula
  depends_on "pkg-config" => :build
  depends_on "krb5"
  depends_on "oniguruma"
  depends_on "libjpeg"

  include AbstractPhpVersion::Php74Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.4"
  end

  def php_version_path
    "74"
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
