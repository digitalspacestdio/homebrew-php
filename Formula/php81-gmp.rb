require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Gmp < AbstractPhp81Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "076ceb29a2fe1f23be7125e08b51ebaa57e8479b8a92ce14e64bb838f48645e9"
    sha256 cellar: :any_skip_relocation, monterey:       "479ff90d310ac0071c20640cbff8ead268bbcd9cab1fbe2d81127e4f9db7560f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aa2981a2b27205939703061a312a551337af3a8bfa8dd1b8331d6431ef5f336f"
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
