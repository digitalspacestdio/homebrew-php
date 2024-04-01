require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0f17f7186132362ef4d527bcba9239e4b092cace9764d352f5ac7fc8353dc933"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "dcf66010b1c99a8042bb143b00f5b5d3a15ad0dfab789e742a03126013bfe3d3"
    sha256 cellar: :any_skip_relocation, sonoma:        "d1e04da435be5b2308895da6b9e0199d3688e4ffb508a3298ec6803ef8bdf8c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "83e0fb77615ad42fcbfae8acfd7a0fa239fc0a40608f2f8642a2640bb188dd7d"
  end

  depends_on "digitalspacestdio/common/libpq@16.2-icu4c.69.1"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["digitalspacestdio/common/libpq@16.2-icu4c.69.1"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
