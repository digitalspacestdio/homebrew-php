require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82PdoPgsql < AbstractPhp82Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b20240c2c8a32e5b19de0b205a0ce9f6745ef11b0f2c26d27021632c84d8b4ff"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "991052832573ad801efc38f491f2afda68000942a756e516ee24962d3ff40447"
    sha256 cellar: :any_skip_relocation, sonoma:        "f1f90137266f0dd4cae1a52bcb05df09fe768a22069b8d200f91d1ec32fd4b4b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "314d2b8efba26fb297309f1548982e388cd071e737f3b1724d9fd53b5cc5ef99"
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
