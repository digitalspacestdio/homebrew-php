require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Gmp < AbstractPhp84Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.1-106"
    sha256 cellar: :any_skip_relocation, ventura:       "e4cc86911d36101de535278c2a98e098f460c8b410b9942e22bb35e9576f82b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f067580f0bc9904be054ceac2729faf4ce77c90b5c7a96443e639af58992661a"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "6035b4c95d44c2dddd8e1db1637eb832ef4974dd7794d85829e9bcc930ee588c"
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
