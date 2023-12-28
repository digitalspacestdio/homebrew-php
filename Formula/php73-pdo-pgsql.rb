require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73PdoPgsql < AbstractPhp73Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 21


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d684c6bd2c210f8c825c3a47c03f0c29062ae9b11fdf781c41f9194bc6f4f3c3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2714e7f9d28a71f43b0cb835490c35b8b64d73459d3c1ed75cac438e3318c90e"
    sha256 cellar: :any_skip_relocation, sonoma:        "3f993d0bb324838fdff4d60727988707f166fb6a823bb77e84ef0444de89eeb4"
    sha256 cellar: :any_skip_relocation, ventura:       "59fe79462b6e0de0891d4e47a5c6f23bf9ae3ff6d550ce3e2a0b3f420b7bb350"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4eb5fe8fc0d289436b9e18a9589dbc1d7935b3d411e7e64790e87471fbd3f238"
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
