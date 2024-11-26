require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5399c6720580763ad2775decc024a50ba488181ef729b7628cc432d742d1ca5b"
    sha256 cellar: :any_skip_relocation, monterey:       "76cdcc0bccf7d821b648911e098e7c0f982c72c4b2fca8afdd77bda308d9896b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "69e06ad8e1daab330b4a0eefee70c869bf3397b6520d9a9a88b57241fe8514c9"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "7ac96f81fa35cba1754af4ecfe138fcfda95b1fbae15ded99680e77de43dddd0"
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
