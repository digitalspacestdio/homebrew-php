require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2ec67658c26ab6a3a5c24c458311028d2ce3fdc99b9361e5520bac0a37341305"
    sha256 cellar: :any_skip_relocation, monterey:       "45e3fe4eca96edaf5cef5322761559f2b4d97c4ee0a2923c4f86b6366d821ebb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "af6c0391530d291b67784fab9323bc52d177cde8bf27a5df88c6e912c2134680"
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
