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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "69aa51b6405fb6095fe6372da688789c6fcf01f37c530f8f97ddb45e2c110107"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d3bdc8af56dcb8e417a60fe5d3d9c39079bfb66c655a2d3d2b241f9994a8238a"
    sha256 cellar: :any_skip_relocation, sonoma:        "69ec314600876358a88e6ca6807834bd491d96c495c878b5c19d744383c2c194"
    sha256 cellar: :any_skip_relocation, monterey:      "f30dff1b37329556beca26bf3b3e805e6f5ebf086b9829d30527025ea86fea00"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b2275ee7016765ba805c7e45f07709ad6665f9709168086de131ad11138ec043"
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
