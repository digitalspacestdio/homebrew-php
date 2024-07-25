require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/5.6.40-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c68b158fe0895c112ff0c20fda507f582f9dbebce47b0e6272f86c084dafb1e9"
    sha256 cellar: :any_skip_relocation, monterey:       "74a412f3dc9ea6966bd25e222a76eef540c7a9aaf3a596beaad3477a12586546"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bbc9a034569a085ad3c98b53955a52df34a2b27f043717386d76a1bbce18e4d1"
  end


  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    # ENV.universal_binary if build.universal?

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
