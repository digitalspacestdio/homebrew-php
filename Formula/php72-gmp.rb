require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4b2ca60220f7cc3ffe216bd4c783d0532d515d5c160f38d9eee1280f720b18d8"
    sha256 cellar: :any_skip_relocation, ventura:       "e17a81e4d5ebd68d3db2eac353c7388b0fbc1ef74a9792b3236b242bccc1b52d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6a8ac9d660c9cb50495ac56304a90f63205e18ba1f38d0e2169928ad37bfb7a9"
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
