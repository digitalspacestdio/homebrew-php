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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6db89c26d40913f3361f4ddb3ae5fc1b30b4199f84dc54e2f8615177974a7314"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3f1acff88dc8d73ffcb1734fd83ececc3f6917a4bb671e0d2291b7d70fbd1754"
    sha256 cellar: :any_skip_relocation, sonoma:        "a2d977357e29c483f6175d8608783868d757f70e681521d6d53b49221e0aec5c"
    sha256 cellar: :any_skip_relocation, ventura:       "54b0a27870ab70deacfa40dbabca53d2b3e8cf6fadecd35c60063f6269d80f83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ff5723f9bec66940222e62e6a6a0d04d9723c9101dd37e81edafc495fb62702b"
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
