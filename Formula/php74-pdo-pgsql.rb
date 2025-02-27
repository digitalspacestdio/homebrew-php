require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74PdoPgsql < AbstractPhp74Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "73d51dcf170dca5ee0536e60b0b8c08b9b9f89669f99d2e3f8cd3050021c2481"
    sha256 cellar: :any_skip_relocation, ventura:       "c1fe3a870a7f4c6305208afb342665052e82d36d98d891044c0c346cb088e68b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1d36cd82e4bcc0c9c28a30a0df944ee64162129ba4d84a359f8d11e12cfe2b2e"
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
