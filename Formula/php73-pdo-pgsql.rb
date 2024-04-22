require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73PdoPgsql < AbstractPhp73Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0b408b75715979c869aed4068b0f74ff3653a8d9fa3ef045db882298417b9f61"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ffbc562bf8e7b7d9c7bc1e952abd60a286618b0e007fc21562f6826ccd3393e1"
    sha256 cellar: :any_skip_relocation, monterey:       "4223297159878fc96c355fb8d98c35e1e0276ea0d7d674cddb57f49c18a90c36"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b9ab3d85669255caa572d5a3ae5d0d1e7d4cfa62fc5246bca21d9c461ea1cb62"
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
