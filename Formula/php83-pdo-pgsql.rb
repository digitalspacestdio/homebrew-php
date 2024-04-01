require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83PdoPgsql < AbstractPhp83Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6a339f00d9f03017b515b9d49ca68e1df2d5364fb7f95d03e1771fa73ed31984"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bafd9f7652a84c3328b8d4f1183b05d0d9c25fa9cb4cd62e6f49a0c762a39f89"
    sha256 cellar: :any_skip_relocation, sonoma:        "d07bd6506357b96ae38b8ddec520c0f433111d4d702415db29120a3e386dbddf"
    sha256 cellar: :any_skip_relocation, monterey:      "252794ebf8bd6922395921777fd54f5bc260aaa33615b46e77624f7417487826"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "06d5545c03eff07d0c60059c8294bc530fba27fe7e506de6953f13f8111b00ab"
  end

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
