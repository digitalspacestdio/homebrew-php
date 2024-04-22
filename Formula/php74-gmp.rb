require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Gmp < AbstractPhp74Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5b1c8fb7b08048e17996a1e6296a254b8faecf49dad45eb59cbae243b11045d6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "acdc97cba7f4522a30dff22fc01baff2d1254c1c85f7a24d4d0405e4116175c6"
    sha256 cellar: :any_skip_relocation, monterey:       "8815ab1e01f81b2b685ace86ada9244a4c196ad15e7e51f9e98dcb2fed5c2821"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "067ec54c41875b861d6f036d3e5194b70918aeb0b339185db2b48d98dd307a44"
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
