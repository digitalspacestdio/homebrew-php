require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74PdoPgsql < AbstractPhp74Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-107"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6cc9b83bc0404b9330f88860ada61e626686b89083faf2219d861bdae0b51022"
    sha256 cellar: :any_skip_relocation, ventura:       "a2cce6122ffa90909ac624f7f8c192b40359055df7dbb4e0136071f2350c9504"
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
