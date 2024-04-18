require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Tidy < AbstractPhp82Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a07b2b9387c94295f63733e813f41ac73accaba927f86defe3030e8bb9e1b147"
    sha256 cellar: :any_skip_relocation, monterey:      "df9b1881aca1b047c190061d51e8afcabd47d19804ae1cb17b8b2b125e205efb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "845e77c13ba4c92be01a4718711833d384d3df0b9a869446022de955b4ae3a88"
  end

  depends_on "tidy-html5"
  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
