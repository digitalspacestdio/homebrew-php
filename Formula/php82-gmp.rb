require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Gmp < AbstractPhp82Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.2.20-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "005b1389c6edcef3454ea913898ed721a8f5d37d8d66c67b084b046d84539105"
    sha256 cellar: :any_skip_relocation, monterey:       "8429afa9034f64157cb3ade94ff79c58fdc94d31ab1ae321032ee33aca23abb5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "002db4559f53642b235b359683ebc69ce6127b2773165eac9f113c69dcee833b"
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
