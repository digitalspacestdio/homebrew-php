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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4adfb96b7d366ddd14d6395518a684370bb2b39cc4fd5689368d1739961a60cc"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9cb50eaa2b51a6a0506fe01aca20f2d062ffdecaae5b9be017e26e8f0d52fcea"
    sha256 cellar: :any_skip_relocation, sonoma:        "95e305f01281ffc54e076b68f756c64d990617421227a558d284521042b4a730"
    sha256 cellar: :any_skip_relocation, monterey:      "58063d2ec1bf2a19dbbead02314a01a11f3dca227461ac77a62b65ad43045ff1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "814e847f3206ca86ec9b015e8532e0122936d4235a4d045faefdf366204e3c9a"
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
