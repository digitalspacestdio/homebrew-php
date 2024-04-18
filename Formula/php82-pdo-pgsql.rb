require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82PdoPgsql < AbstractPhp82Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cef3bb35f2ad0d1046c6d525f21a40796871fe6689b9f2c5ab3b0ebef9498d3d"
    sha256 cellar: :any_skip_relocation, monterey:      "f8f879f861b67d29891c354279b2045be9b1eec2a1ecd8e3399e61f9636202b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a7df76bd26613ba3ab7b1b867005e5082b6cf837eb3cdcaa1472af8d38b4d8bf"
  end

  depends_on "digitalspacestdio/common/libpq@16.2-icu4c.74.2"
  depends_on "digitalspacestdio/common/libpq@16.2-icu4c.74.2"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["digitalspacestdio/common/libpq@16.2-icu4c.74.2"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
