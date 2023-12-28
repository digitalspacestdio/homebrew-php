require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Tidy < AbstractPhp74Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 19


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "439f8e78b9d30724e42354d32a5d7555816baa984e6e1880cb2ea079b56d2a53"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9a36f0c1a31446fe26dd0e067df14347c9ca6a086af9fcbc6e70b68c3b402801"
    sha256 cellar: :any_skip_relocation, sonoma:        "502e7f4d020048eb5976b90a4836ee39a70d3639c761c16a9c5038188ca41b14"
    sha256 cellar: :any_skip_relocation, ventura:       "b843df1a83c6c7afd4bfa028af70a09f3e9ac851fdc45f892eab8a611b9521da"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "910cedb020711834c21f5c4380d6a40a8d011bdac9b54d09767996e3a18f415c"
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
