require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74PdoPgsql < AbstractPhp74Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7c5de2334dc32ca07c3330f26b6349aec2faa992d4e7b5446a771d8d9a6352a7"
    sha256 cellar: :any_skip_relocation, monterey:      "496d8392d17f9a29d827cedb7bf8b1de4a0fec469e0cfc7fe1bbb6dc23ad64ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6ea03e3ba067876e959dde433bd264ea273e61107124d0dc3d9d800c7b2784e1"
  end

  depends_on "digitalspacestdio/common/libpq@16.2-icu4c.73.2"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["digitalspacestdio/common/libpq@16.2-icu4c.73.2"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
