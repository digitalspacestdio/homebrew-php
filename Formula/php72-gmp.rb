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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c298d2974c3520137e7957edf6a6337114e77e913e3c28a720c3145b25573cf6"
    sha256 cellar: :any_skip_relocation, sonoma:        "4ecf4b2ef35c8d172422fe4b250de7190df31cd56027440646ece33b6be0fac2"
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
