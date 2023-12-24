require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 21


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7d232ea668d6aa099b5cadfe7de39f6c0da68a79234658410879e0e2fcaa6d1c"
    sha256 cellar: :any_skip_relocation, ventura:       "f2e865d72f1a448f4f03981aab55f0e2a65cf248fcfa82d988c4e8b60bb2176c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2bc2ed57f75639a69ecf8ffe8713bed70e972a371c4b35c4954417bdafd74dcd"
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
