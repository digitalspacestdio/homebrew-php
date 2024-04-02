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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "01fcb128774dfdc8e9ceb17d65a5bb3522b21fc791a238d8a48fe6778d86b4be"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a52c02f3418d1bb4b3242017327ee3849dba1fa1e54f836d469bca649c742af8"
    sha256 cellar: :any_skip_relocation, sonoma:        "44bf4913765b94474b1d080698903a1412e1a118820b851511d1ec6530a9ffe5"
    sha256 cellar: :any_skip_relocation, monterey:      "31712e81040b3a6e9a8312aa4a5af883755f693e8833fcce228b70a69e3c6c41"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "079b41c0dcb757e29cdf4259529d130ba62ae7e575b30d94eeccafb74bf08845"
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
