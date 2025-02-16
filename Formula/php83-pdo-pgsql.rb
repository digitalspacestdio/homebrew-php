require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83PdoPgsql < AbstractPhp83Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.16-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ddbc866b64e8fd73fac2b6fc4644398923c03c2dd7c1285258d57b9343a2d89a"
    sha256 cellar: :any_skip_relocation, ventura:       "476b0d4cc75459174400c026703a30908d7f3826850e0503b7b4a6dde995c6ce"
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
