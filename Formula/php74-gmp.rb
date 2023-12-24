require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Gmp < AbstractPhp74Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3f5f54eee8a4dc880d4d9c9e0763aa224d7c08b242f867d0767742490086da92"
    sha256 cellar: :any_skip_relocation, ventura:       "fc548466d4ec8216bf1fe15441d5835fbe26bfb68e3de988798c5037c2d93888"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bbbd2fb07a7b6316147998d7788977e7110b22e53d2b84aa7ff8362dbc1afbb9"
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
