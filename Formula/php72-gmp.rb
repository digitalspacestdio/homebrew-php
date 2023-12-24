require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "350e671871a0dd6e5db8cb29aac982db37fcb28541d71aa1b1fed0bd843f4199"
    sha256 cellar: :any_skip_relocation, ventura:       "308bfef607b3eb26a92e488052e724ca116708afe43c78ac2014d6c08b83c88d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bdefbf20214b0ec820e3d4ae486460f5b2e133c03e3c7c5021866a0c51ba886f"
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
