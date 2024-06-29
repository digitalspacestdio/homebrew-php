require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Gmp < AbstractPhp74Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.4.33-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bed2a3e36b3739fa67e8c8468b4bf05cf9970454d7a9ff11441d3e69cd2d076d"
    sha256 cellar: :any_skip_relocation, monterey:       "f913268e2145df09ab3376d0155e9f23ea335b3b7fec1d4f98a616eaf7a1a16b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cca177c48af1f3a0577f72d1b654d7c468edf63e62e5c5da507c898994214998"
  end

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end
