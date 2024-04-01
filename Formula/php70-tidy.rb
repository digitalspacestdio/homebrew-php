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
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "2a671508bb358ad69a5b8b42a0cd8f63ced46399525e8fea2c988e24f0c2a974"
    sha256 cellar: :any_skip_relocation, sonoma:       "1ed301f9855f1b80e5b271cff56c8b4ef6d6167160c4ce7a6a76ac5209ebbbc0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "88d90bb851e5235a520e5094f94192f004800b262d2ab57fabf6468497cc22e1"
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
