require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Tidy < AbstractPhp70Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "459b2f0179359290c7f909db1447a2adc39ac9d125602f5c065b86de3b63c584"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "41f4d448092f150726be31570cca7e06e6d684c4fcd5f9aada84313889127ee4"
    sha256 cellar: :any_skip_relocation, monterey:       "7ecbf11fbb69f80f5871d0c7ebe4e7cd6c1913c86a910ee1012d048d810f3a87"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a096fca194cf1fee431ece785ebb05abf3d565fbe076f6184bf913e469ed94cc"
  end

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    # API compatibility with tidy-html5 v5.0.0 - https://github.com/htacg/tidy-html5/issues/224
    inreplace "tidy.c", "buffio.h", "tidybuffio.h"

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
