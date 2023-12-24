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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e975b633e6d4dc6ec8ce0a7ee71ba50178bb868f8c04fb6b05b9fd69d38f32ec"
    sha256 cellar: :any_skip_relocation, ventura:       "59fe79462b6e0de0891d4e47a5c6f23bf9ae3ff6d550ce3e2a0b3f420b7bb350"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "99ba3bdb5cdc9db96ce464a5eea0076078572893346f4296683bfaa63663db43"
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
