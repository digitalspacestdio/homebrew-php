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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9f2aba8c0a69a737b2c5e704d3ce935f60dacac3d1f18f60ae35a02b951f6d23"
    sha256 cellar: :any_skip_relocation, monterey:      "11e06af4385a582f2fa0a06ff683caaa53fc570442e2da621ecade353346c75e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "75782f4e1ea23de373ce30b96809b0e5b9a7377ac11f0a2968a436f9095adbb0"
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
