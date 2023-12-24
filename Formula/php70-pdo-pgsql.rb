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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e8541b3c7718039c87398feb9fbf64e5c62b44e7accfa8c025f311a590459f28"
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
