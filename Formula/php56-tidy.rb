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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3ffbeace0ee62a9c34c1d18602f96c4a85a3408424a44d98ea0caa37908522a9"
    sha256 cellar: :any_skip_relocation, sonoma:        "5f3f6d3f238932a15013387c9a70a02db302ac9c796ca5c9dba5381bdcac1400"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f0b4590a6ac8ad118fa840c1c4483ff6fbeabc612a8cb5c5be7fefff7d825c0a"
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
