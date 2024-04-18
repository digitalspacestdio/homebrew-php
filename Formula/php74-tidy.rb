require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Tidy < AbstractPhp74Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f6df3e48751859293daa04a098d7348d9311cabc9dbe8934512850a0155064dd"
    sha256 cellar: :any_skip_relocation, monterey:      "05a326f335d1e0b54714ab6c2b1e2fdbe8840ec343b3837b44c4860fbd80656d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6a43448d9b752514418bfe23801c1551829f17ade42293257cde1a001d73968d"
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
