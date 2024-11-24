require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Sodium < AbstractPhp72Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "77b234d7cec5fc0b957a90fc6175de3396f3de2db1dd9410cb9f22de7af76e4b"
    sha256 cellar: :any_skip_relocation, monterey:       "d1b2ea3b4461dd5b63ef4553d7e4bfd7aa629a490e929d83e489a7d28ce931f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eca789f9c0cc0cf2e51a6fee097a1b6365b6a84fc45d09be7a1f363acb039cd9"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "d709cdacd40b81e8429be0c4176579ad3b7785af2802fee3b84a325d9f9f88f2"
  end

  depends_on "libsodium"

  def install
    Dir.chdir "ext/sodium"
    ENV.append "LDFLAGS", "-L#{Formula["libsodium"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["libsodium"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-sodium=#{Formula['libsodium'].opt_prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end
end
