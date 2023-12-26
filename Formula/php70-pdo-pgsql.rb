require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 19


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f345184c5338a5695c45525566461e25f2b3bc9497bb632a508050008937464d"
    sha256 cellar: :any_skip_relocation, sonoma:        "d4c632bf3b93b330c6b0213303a3258f7d299d5e5ba7a86452a6c03392478a32"
    sha256 cellar: :any_skip_relocation, ventura:       "ef84e1948529da6f6cf4134a1a439688be0a540e2de99b631158d4921e260681"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f6f2010c55556e9b5dc5e19f61eaa51770f7b40b4073f9e358c518db9db70ada"
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
