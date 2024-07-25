require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Gmp < AbstractPhp82Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0d0b9f0117b6b51f041884689f043cd06fde20d009516776d38d2e20034122be"
    sha256 cellar: :any_skip_relocation, monterey:       "f05c672a9dca35c4b01744fb0b5769b76099f0d506d1da03f195af788d28edcb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ca7e9eb6d1b9235e779381370f44f661cae2f98c8ccdb0adb7f8f2de03942b73"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "1b75d5c2fba69eea01d4a53a69ed4fd467038954d433b3b9cb90b2fe2bb1d844"
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
