require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Gmp < AbstractPhp73Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-104"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f59d78d54778934dd8894b0ee18f9bd16e61739aaff0347674bb4fb63bdcc15e"
    sha256 cellar: :any_skip_relocation, ventura:       "322509158e9e7f6aa8a3e42073c7a9d355a62d42f30cb4fc62651f68b1ab9782"
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
