require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Gmp < AbstractPhp74Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "84cc67aebf826c550b0b37716d58c516ab00033c3a2b9360eb0aaee890aad45c"
    sha256 cellar: :any_skip_relocation, monterey:       "bb86a850ebc5f0b97fdb6262ba60f7c6a30f21e9fd0e8e2221df968acc577488"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "50131d6f17bfa52f83508d48e63409ae6e48044b8093e9e94cfa3e61efb3366d"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "32bf33e45d340e008217730c742498378014dc2ac7861662dfafa904f27cd06a"
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
