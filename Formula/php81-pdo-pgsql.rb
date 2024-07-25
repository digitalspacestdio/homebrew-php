require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81PdoPgsql < AbstractPhp81Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f3321b94ecc1ac7c701cedf4d521b28c0cb0fcc718d207a278cef5acf846b497"
    sha256 cellar: :any_skip_relocation, monterey:       "be76f636d8b62e4be78838df8824e17c3e43f5c8683a264202985fd38aa2f335"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4334f1eeb10d2902f1608a4b9abfb18e4757f7f907b5271e32ed4297a416d0ab"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "b90f922002bf9647f8cfb1ba2c4f3e99efe2c403d31114450df9cee2cb6f7e83"
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
