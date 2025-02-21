require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81PdoPgsql < AbstractPhp81Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d4f124f9d6f76f83c836f0d99d18270dfc115d2aa12bb04414f2b8d3db3dd023"
    sha256 cellar: :any_skip_relocation, ventura:       "f1d24fff04bd3131b15f2ab1f192c1ec7fd05b31b489dc0f65280e1a60ddf202"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2620cffb9041679cc3a8d4ce20de292975c0f77da16bccce3928fd4b7dfb21d7"
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
