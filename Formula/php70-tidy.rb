require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Tidy < AbstractPhp70Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 18


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8e4f28e6bbf1f2c2d82d829b350afc1449da3bd4df1a5435194e9cbf93f923ad"
    sha256 cellar: :any_skip_relocation, ventura:       "54b0a27870ab70deacfa40dbabca53d2b3e8cf6fadecd35c60063f6269d80f83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2addf032ab76e8a26258ea392f99b3e35ee59f52479a4d57a584fc9363b55edf"
  end

  depends_on "digitalspacestdio/php/php-tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    # API compatibility with digitalspacestdio/php/php-tidy-html5 v5.0.0 - https://github.com/htacg/digitalspacestdio/php/php-tidy-html5/issues/224
    inreplace "tidy.c", "buffio.h", "tidybuffio.h"

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
