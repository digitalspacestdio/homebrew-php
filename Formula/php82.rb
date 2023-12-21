require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php82 < AbstractPhp
  init
  desc "PHP Version 8.2"
  include AbstractPhpVersion::Php82Defs
  version PHP_VERSION
  revision 1
  keg_only :versioned_formula
  depends_on "pkg-config" => :build
  depends_on "krb5"
  depends_on "oniguruma"
  depends_on "libjpeg"

  include AbstractPhpVersion::Php82Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "#{PHP_VERSION_MAJOR}"
  end

  def php_version_path
    "#{PHP_BRANCH_NUM}"
  end

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "839967cf398baa60fdd0693c504adc202e3f9447367cbd5ae39f6833a766ffe3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9e793aa5bf0137364d4dab9903609bca0b8c8bd7bacf82f33e7e7f094585c479"
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
