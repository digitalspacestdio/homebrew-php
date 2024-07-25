require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74PdoPgsql < AbstractPhp74Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "334dec5ca032d8a914c85c9e36609969bc326f26a5ac7ccd6d2f86eb6d71cc90"
    sha256 cellar: :any_skip_relocation, monterey:       "34407b13aa3f51dc13888c2b20e5f62a7e9bcdb7ac991903dc56b054f73bd2c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "82f1272e00566ea0d1892f1e330bc614bfdcefae1d10c044850a5d33a7810cca"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "361eeed1eccf198100705ed4488fe8e77c818d1362545e7915d737c2f897e2c7"
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
