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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2a671508bb358ad69a5b8b42a0cd8f63ced46399525e8fea2c988e24f0c2a974"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f0bedee57617af5c28fedd1399dc6b0e915374a20eb3bb3eddb4e04cc2f78012"
    sha256 cellar: :any_skip_relocation, sonoma:        "e2fdc078103a847ddf8dae98558a412cf2d6e9333eb3aa8b3494527169f87c2f"
    sha256 cellar: :any_skip_relocation, monterey:      "a67f31e7b617266857d3fc3b8f943b958e731f97d73999750aa9d05681c6db82"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4b033b3b1edfaa345738cd1381233afbfd709b0c5d9787c8b06e1825f16ab397"
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
