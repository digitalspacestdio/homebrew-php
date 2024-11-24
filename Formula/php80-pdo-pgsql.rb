require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80PdoPgsql < AbstractPhp80Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b3affc43448f83ba59cc233bf3786311031a189b368a1a6c6d83b0c5f0a906bd"
    sha256 cellar: :any_skip_relocation, monterey:       "4c73e4d0ccd7f1936d440dce7b506ff30b6abcbe1c8e3470ce9793b8f1cbdb96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6dd5b6f40f4420190b630ff4e47135e795eaec8b34aa5c73959d01676ad2cbb"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "04fb142c1f2d1da4b33615dfad2bc8f1e8559f33c42fb51d8ebaf9ea7f50cb1d"
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
