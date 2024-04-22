require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Gmp < AbstractPhp73Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "43c3a49c358dbad1c1c0b92764132a8903db5f5d75640ed0c9e63056212cee27"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "767579df506974d32613d7ae549803abd2dde2fcd1a03dc993b5613a3511fa27"
    sha256 cellar: :any_skip_relocation, monterey:       "6531a832221c5b1b5d156ff5110019e8fd3c1b1aad4db1b295bf4dddcf8bdb93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "38e3b0b280b82a2cd0bac1c7668300e103ff5e7c61992e70fbc655a8fe97619c"
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
