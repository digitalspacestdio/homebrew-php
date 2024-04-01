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
    sha256 cellar: :any_skip_relocation, sonoma:        "315cc455e37470cd161553b9562295a849fbb94ae98fe8b49e22aab4fec1a720"
    sha256 cellar: :any_skip_relocation, monterey:      "252794ebf8bd6922395921777fd54f5bc260aaa33615b46e77624f7417487826"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "097a6a9837b9f5cb5993a45b45f8bd7717baaee3ef58d1ba8c502438084a1f6b"
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
