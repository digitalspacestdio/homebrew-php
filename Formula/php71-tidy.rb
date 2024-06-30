require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5c953c3edf3cdd0475f3539c9ee33987d12cca7e50bdf63b27ed1a96211a828c"
    sha256 cellar: :any_skip_relocation, monterey:       "7cd10db2c444d5171ca49c0cd666d425a0cf192e241be84e211a577f730c67bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "33e1e12f39ed07ce798c0f8ef8003f5804cc3782931a430ed44511e6072d5ddf"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "9cce9a35d5d1d1fc782ce065b15b257ca8d19ef03905afc0a1737200c0ac0c42"
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
