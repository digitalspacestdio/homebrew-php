require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5399c6720580763ad2775decc024a50ba488181ef729b7628cc432d742d1ca5b"
    sha256 cellar: :any_skip_relocation, monterey:       "76cdcc0bccf7d821b648911e098e7c0f982c72c4b2fca8afdd77bda308d9896b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "69e06ad8e1daab330b4a0eefee70c869bf3397b6520d9a9a88b57241fe8514c9"
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
