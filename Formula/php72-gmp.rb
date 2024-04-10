require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a90a60557a907b5610fed7fda7b20b3f0f37be95a4a018409f8c0bda7108a810"
    sha256 cellar: :any_skip_relocation, monterey:      "8a1e32913f4504f9f64e7e7fd7658801b439a2f2b2b56d5246ce18147d4dbb4e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "89b7f19ec29106f689ddb4d7b3e138ed83a9b275ebe9a5e22050d4839ab214b8"
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
