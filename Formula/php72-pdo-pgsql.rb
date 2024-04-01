require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "103981915f8392a241d84ad95e525d47a3c79233825703222be9e3a2cc8525ff"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c35f0a2e8cd4ffa59b52029390e63727a5d254c27445519a68b1c47a1d063a3c"
    sha256 cellar: :any_skip_relocation, sonoma:        "203694f8f810b089a37839fe115a4675f5922f39851bdf352ac0a9f0a55edd72"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dbfcc360b0700f91e7e96198f99d26351c189a3c0e81337e38f751a54506d2c1"
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
