require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80PdoPgsql < AbstractPhp80Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "df79821ab6882d23b5cde754b7b6a7148238d6f3c8763faf684d11341a9f262e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d35d85f78652de1b386bf08db2c04e20df30e2d44887701e9b4fb534930a96be"
    sha256 cellar: :any_skip_relocation, monterey:       "7035cf03b44efee4cbe0265be9dbfe4abd1f7b0b810d66834596cad29e8f07e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "93655e6fd4be3bfdee4c13d3785aa8e96df7412ab47d66ddd89214cce16c4b0c"
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
