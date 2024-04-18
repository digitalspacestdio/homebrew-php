require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81PdoPgsql < AbstractPhp81Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "75b99c529ca7426fe0db6e37c48053b5ce259fba0e73b8c98f3131c742894301"
    sha256 cellar: :any_skip_relocation, monterey:      "d7051342d01db981c343c287035837de458b10e67bb808e30708c9e6d689ef12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6914a13675a4bf303c133d4653ce4b0ff48f3c65fe535518ad79215c65f6ceee"
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
