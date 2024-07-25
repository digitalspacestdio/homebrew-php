require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Gmp < AbstractPhp81Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cd50f87379309fb32c6463d84df1b4e8cb049de0023c612a9c3179fc3447be6e"
    sha256 cellar: :any_skip_relocation, monterey:       "458aea1e7411eb723428bcd460418b182c52d6ab28d8930e2801229d6935b7bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d7f4580ac997114f221532f99e8f40b4b4c8d743a44bedea5a5c1cd3c3a5ed9e"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "ffdbf4b17e30cf4089f346defd1ee03f6d54b5de995df5f95a0fb919805319f2"
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
