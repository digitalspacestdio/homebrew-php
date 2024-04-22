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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a90a60557a907b5610fed7fda7b20b3f0f37be95a4a018409f8c0bda7108a810"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "99783b2e8887ea7a73ca3890f83bb9170605e0e313a2dabfc1c370e863fa259a"
    sha256 cellar: :any_skip_relocation, monterey:       "e08f3cf79405a5ecb01dae0ed627e2e8b9531befa548ba5f7e79d83b4c16f71d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "69171faba0edd288cd3127b1be2d9c3012667b328d03dd75c4cf4e743172d213"
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
