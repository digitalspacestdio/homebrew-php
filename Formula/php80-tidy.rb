require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Tidy < AbstractPhp80Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b9b1cb87f910b00064712bf032e59ef98cf8dbef8f6f652cba7dde69dc8e8796"
    sha256 cellar: :any_skip_relocation, monterey:       "aa4e7f059252873007eb7d663085fdb09b18c2e79aff1e63f8e49c2eae7ceb9c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "81bf03f5b8cb4e211206dca37aa17e0ce7c17e75f92990a504039b077c1caa65"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "a25954cbb4992c2d1eda0920a325cb1b97d4d4f3b4d30674ccd3eabe18d1e9b9"
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
