require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "254b69d88a5ffb673a701a496148b71d9533277708125f392ef8f15e05f648d5"
    sha256 cellar: :any_skip_relocation, ventura:       "afb7d4440d5e6b748c805ecc6d3401714dd8c340933e147df2352d70434def5e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "36e91c80673422d812e924b163d8c6cd102ddbf30595a4b4509fe64bf9bf5d27"
  end

  depends_on "digitalspacestdio/common/libpq@16.2-icu4c.69.1"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["digitalspacestdio/common/libpq@16.2-icu4c.69.1"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
