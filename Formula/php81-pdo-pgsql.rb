require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81PdoPgsql < AbstractPhp81Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "aab74e86f10e54d2228f586a4cc826314c58a748de3c22195f32c213d40ec78d"
    sha256 cellar: :any_skip_relocation, ventura:       "016e08c19d949b618864004f224b467d08cdd6a162ae68897468747e6b63f5ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ecf368d6721bf6cba7b74e2f09404aa5b17a2088d3a843ed5b0548188087f15c"
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
