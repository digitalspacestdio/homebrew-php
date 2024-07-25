require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Tidy < AbstractPhp83Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.3.8-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cc144bae7e6662e37e76cb2a0e2d78f79619a787b08c68832f92794a2e6d2b81"
    sha256 cellar: :any_skip_relocation, monterey:       "a7554b88ee12c3aca45f39a5220d26fd49e27f2e66c407b1676470195db6053b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ddf3c2e46ce1aeefdb31691e349560cfccd4ae3163adf399c76730a0691ef2f2"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "d88fdf6e33474511197914b48e40810723804bf6c85f739e964d8b4a1c1c2d48"
  end

  depends_on "tidy-html5"
  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
