require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 21


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2283342fc43ba2b0b003fe41489541972a9be786ec2e1d8c5aef2da2c6dcc56f"
    sha256 cellar: :any_skip_relocation, ventura:       "fda12de570ed71443a5d993578c62e0fd3dee305ac176002ba79af4a0fcd5c2f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9b0b5e420c93196a48355d1d664afabcc6d789b84f1cb8897ba7f3e298bddfd7"
  end

  depends_on "libpq"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["libpq"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
