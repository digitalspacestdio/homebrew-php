require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Gmp < AbstractPhp83Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "75390770a5a8ef8589dc4e6e372ac2079aea328dac3259cde81e3ca04d9b6242"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3eb40b779694a689ebea7e533169aac9f4db6400184d5932743f7302e120357f"
    sha256 cellar: :any_skip_relocation, sonoma:        "ab08cabcb8b620facb871f04a36a99be7471e958cf02f1075ee533d751cdb4b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "71ab0b85fb2a0b01dafd1f0df159b7586bebcef46c679eefde6d50abe25db2d4"
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
