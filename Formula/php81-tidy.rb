require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Tidy < AbstractPhp81Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "af920b0d532b81f37c220e14c396672fa5f39fbef2fce9a7e738687f5e8d06da"
    sha256 cellar: :any_skip_relocation, monterey:      "d9d4a8a450f4bb4cdfcbed3ec10d6fdb6bc654a52791d6c68fad674c379b7b67"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3310e22cc3f69591f5bb029c10d8c53eb0ffab0f65aa5c7b2e5b43f1a2be4a39"
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
