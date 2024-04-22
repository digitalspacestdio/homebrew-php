require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74PdoPgsql < AbstractPhp74Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "119b1cca12ebc02ea15cc437e4f9a977b4aa234abeebf8877e1d99999bde24e3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f14df15767eff1915a8d2bbc2d1a2c7c9a58d1e1fb0c43b0543be662b29b97b9"
    sha256 cellar: :any_skip_relocation, monterey:       "0d1cc25690d344738a1a9332e079411c953583b1ff73d2445cd485c7ca9483f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ef7081c74c9b8a04d61ed617a396b968269559bff2adf450600289c134b8dd4a"
  end

  depends_on "digitalspacestdio/common/libpq@16.2-icu4c.73.2"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["digitalspacestdio/common/libpq@16.2-icu4c.73.2"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
