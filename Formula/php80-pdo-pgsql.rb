require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80PdoPgsql < AbstractPhp80Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2ba46317e07298e2ae8463709824be7401b82325f30acbe0dbab82cbd3a8b160"
    sha256 cellar: :any_skip_relocation, ventura:       "704e80b5abc6f8c2f9c51d17f2fd73cbedd2866a19199f49822ff85d77cc1a7c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "29d0e449a3137b8be453c2bebc1e83a79b95f01fb99232c10b2034f037b78d0b"
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
