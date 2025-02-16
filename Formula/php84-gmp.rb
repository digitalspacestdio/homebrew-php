require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Gmp < AbstractPhp84Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.3-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a337d708ded8d61fc02024d4ca09b6b1d7369ac67e4469d4efc4c7e2c901c11e"
    sha256 cellar: :any_skip_relocation, ventura:       "17c39f112d6ac2aa80d574e65d84cd37f9cefb99ba932e6f741f8ba5f026a1cc"
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
