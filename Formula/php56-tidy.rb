require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Tidy < AbstractPhp56Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e147fc1b9f32ebd1b1b3c53b726d24e477d59ab97c4e1caba6f4ccbed5fd3a5c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "df4980c978739083844852cd4c9d43783ec12f39449143782d62b70cd21df7b3"
    sha256 cellar: :any_skip_relocation, sonoma:        "1385e719bea4681b903161d2aeb6d99565e6613286da10d738478a5b10fe931c"
    sha256 cellar: :any_skip_relocation, monterey:      "196b2fdb6b5ae03cebd3bcef6995c4fe363e4adbbbded3ab6af5aa04cc56b23b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "628ebac8143ec6105fb572e811998c5c996837a1447a01ef313b02b90d71ee68"
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
