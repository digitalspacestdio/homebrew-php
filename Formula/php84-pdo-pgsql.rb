require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84PdoPgsql < AbstractPhp84Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.4-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "072def3fb608b216537231684d98a7c2d4a95cf62778272a82c1e8a6ec5667e8"
    sha256 cellar: :any_skip_relocation, ventura:       "6c9730472becaa7842e8653a548a528c06a8b261454f73de5cbb58a87131fc93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9ff2cd38cec68c130150396fbab7148f916dd768348d27af4b5a790605275d0b"
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
