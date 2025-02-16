require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81PdoPgsql < AbstractPhp81Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "25bc98cf1caeaccf86d9d4c8745a547b86f41f5a4040fcd496e5d18442cfa204"
    sha256 cellar: :any_skip_relocation, ventura:       "4be2c1239a348813df1f0b8203f477287a785e01bdf9e42a8177b6691c9e6388"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "53d6bdc9e36a879e33d98d2171570e2ef21dd3bfd438db13036756edf35abadb"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "073d08959ea062090de5b2e98a2d248cd56031ae2ec219511a7d66fd4340e2c2"
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
