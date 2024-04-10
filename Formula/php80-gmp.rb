require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Gmp < AbstractPhp80Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "96e896c950425a4243323a74b9277aab105234b8b1196f5190d4492680e73e1e"
    sha256 cellar: :any_skip_relocation, monterey:      "dbb9db51887a79d668c4455626b3e311ab20b3b1f850604ffceac04fb531e4fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2abe6695118657c2ff7f9d408ca813f95179b10e1aa3d117100afa29ce4a924e"
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
