require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Gmp < AbstractPhp74Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4146d7078e9019a8d9375d3e40228af891b974cff8cbe5fd1d27b6c3a063934f"
    sha256 cellar: :any_skip_relocation, sonoma:        "1841fe951cb9f74c92a8e4c11f3abfdb958298871658e11096684df9e6c5b8e0"
    sha256 cellar: :any_skip_relocation, ventura:       "fc548466d4ec8216bf1fe15441d5835fbe26bfb68e3de988798c5037c2d93888"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "15855820f244eaa6a996bdda07c7f6192e40c63414b35d0865ce288b501b12a0"
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
