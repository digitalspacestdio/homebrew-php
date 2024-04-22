require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Gmp < AbstractPhp83Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c434df81b99b57765ee483a258ea73b876dcb769e1d3e22aa97b6e8eac9ee691"
    sha256 cellar: :any_skip_relocation, monterey:       "0d37107b4fc3459ad9a571199ccd1b3331c108b6af999f6689ae41bdfc0c77b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e724e36d0fad976e475866179dd63a5333f62ee03de816f4c01039359f547867"
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
