require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "fc32606cf490d18b61b8137398d7b0b993c2b57d29aa5486a251298fbea92059"
    sha256 cellar: :any_skip_relocation, ventura:       "31b7882414ac243d0a8e3795d5ac09058cc815c7e4fd7b35a31290870d577185"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e15a47d01390021b57cac8baa4f439da84250a08dc2d89c10e60f7b5a30f6d9b"
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
