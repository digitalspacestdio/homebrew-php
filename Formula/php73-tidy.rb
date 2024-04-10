require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Tidy < AbstractPhp73Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a43c8364fbe8044ede4597cfe8ad7f8a1b838c49583710e62360216daff7738f"
    sha256 cellar: :any_skip_relocation, monterey:      "4c4fba8a3de9a68f46b8ea889f9e349ae253d7bc3bda548195305848c03c67af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f18ad6be6d88904cf68f5227f92d7128335ad996961bb2cc79dc85eb5a880a34"
  end

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
