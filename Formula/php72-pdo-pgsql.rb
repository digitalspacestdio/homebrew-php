require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "45b0aec8a3a02c0e28da367f6c54542bb3470ea6bd11df4d34e8979da4515810"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5b0ea12d319da067637ed9c6adecc0edbdab908f8ef8e92ddebeccb64c6dd10b"
    sha256 cellar: :any_skip_relocation, monterey:       "af511ada3565780004130ed32d13dea7d85edee067c17c8c26f04f42c934b3c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0425aef700d080b73b4f2362b70082be18c710638953aec86ec4813ed38fe0df"
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
