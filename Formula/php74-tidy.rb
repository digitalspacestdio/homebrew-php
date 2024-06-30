require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Tidy < AbstractPhp74Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.4.33-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a05d24659c49894142abc5ee543d59dfebd358e1183fec6b4cd54fb015c90ebb"
    sha256 cellar: :any_skip_relocation, monterey:       "c00532ffd3791f492e8b1a189ece4dba17f6a7ce95d0bdd406d3983895e0fba2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3cc9aebd267cc7d6abc662803b0f70af660d3b9fe5264913546bdc67ee0410d8"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "5f95f02c4ba8c2e036cb5c9e20b45e36c6f4fbf0c8ddf2296c473464878bb811"
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
