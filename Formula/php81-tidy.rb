require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Tidy < AbstractPhp81Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d1c0d07055df7aa5bcfac3104a09e78f283da5fc2338d96d46088b903159e514"
    sha256 cellar: :any_skip_relocation, ventura:       "937c94ff28727f9d2fc55e9d0dd5715db8fb5671b1956ae240e13114bbc5e93a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "005c092817a326911a1fbf3576c65190786ac08e0cb0996f0065f3db71ee19ce"
  end

  depends_on "digitalspacestdio/php/php-tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["digitalspacestdio/php/php-tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
