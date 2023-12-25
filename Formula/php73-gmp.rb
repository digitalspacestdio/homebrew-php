require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Gmp < AbstractPhp73Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "651932323733fbe0d926682f24b182749a673b6aa9cd4ed714faa5a9fd402b30"
    sha256 cellar: :any_skip_relocation, sonoma:        "2dcb5855cf13fd8adf77aec03e4bb1ae44978f0776e69aadaaa4492b03a53fec"
    sha256 cellar: :any_skip_relocation, ventura:       "20cd82011fc5f10c2bf463faeceef117c05ae2c11e43c1601041e727c958bc33"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5d213b794146704ca799cf88f6c66b6acbceede029f238e37defc2f7a31090f2"
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
