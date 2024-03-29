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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "abb3f01c3848be81b38d2193873e514e3b372b81bbc026b40e3cf4a071d539f4"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "839655974e1bf5cbdf843ad3421015c2f0a17f2e98b31e15253ec84f7398eb7b"
    sha256 cellar: :any_skip_relocation, sonoma:        "4ecf4b2ef35c8d172422fe4b250de7190df31cd56027440646ece33b6be0fac2"
    sha256 cellar: :any_skip_relocation, ventura:       "308bfef607b3eb26a92e488052e724ca116708afe43c78ac2014d6c08b83c88d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "da0407a5c4133821277d3815103f54b5be16c9b4f19dcab29d3754ab14ee9484"
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
