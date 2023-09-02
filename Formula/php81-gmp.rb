require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Gmp < AbstractPhp81Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ccfdf4ffe8cb776ccee27ece6d142a25f2e0e650db3015456fd40bd1b8962ec7"
    sha256 cellar: :any_skip_relocation, ventura:       "62690a2f2172c548df4f2c46c6e39084f6d52f61a9ea231bbe2cebfd7757599e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cf384d2a782b5ec4e8c1fc2dfda93a2a341bda19f799eb2dde7d9bb75a496aae"
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
