require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74PdoPgsql < AbstractPhp74Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 21


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6d561bbc8655837052dc9d9574d83c1877fb948ac559df716687c63fcabe869e"
    sha256 cellar: :any_skip_relocation, sonoma:        "397c91710a205f2277c79d2216ae772a09cd1c306b88d6669f897ca5711ce575"
    sha256 cellar: :any_skip_relocation, ventura:       "80cc1a9bdd2ef6ece1e8dd981d9946d1cdf91d165d8b1f7f8c032935b9f3f98f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b1ac5d22987b6aca3c5cb107ab34916127ffdd028a0bf4930e62ac990dd1bbb7"
  end

  depends_on "libpq"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["libpq"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
