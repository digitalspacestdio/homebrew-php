require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Gmp < AbstractPhp80Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a82422a1e548b2d2a7701ba3e58bba7fef256f2fc14f8e3293745abfd8a9e664"
    sha256 cellar: :any_skip_relocation, ventura:       "ee4b4b7e85d6d77d8a9b6258bbb73903638c637dab0937bee58e64fee30687c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c5492ca8761d1a1c3573cf85169fc7d90d93b0e2ff06cec06c0f13130ddc0e57"
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
