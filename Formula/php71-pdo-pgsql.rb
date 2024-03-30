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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fbd4b7c4a21307a4632852cd0aa9a35f2aecd9a8047f0e793c37d99e4e24c99c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "35c6f86330012bd8ceff2b4ba1895c5afd7db26002c5cf85074614e58c72e3e5"
    sha256 cellar: :any_skip_relocation, sonoma:        "79a1b4451cc038ffd1c43757744fb120633594fea00344e81ddda84856998ce2"
    sha256 cellar: :any_skip_relocation, ventura:       "fda12de570ed71443a5d993578c62e0fd3dee305ac176002ba79af4a0fcd5c2f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d4f9afc8c019c65948b77a67d43cc30e2bc28577487749ffad9a7fb3ce015c82"
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
