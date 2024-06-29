require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.2.34-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "504a81dd62465e601ba98fc7d97afea5fcdbfbec75fdcf2ad7e75175b33087de"
    sha256 cellar: :any_skip_relocation, monterey:       "886fc5d499593c82a0456381e727bf4872279cbe61454a2ac998d274b17e05a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "402d91793f5a9e79c16d0cb00bb3bd05f1e89778038523f5a6042ee57bcb011c"
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
