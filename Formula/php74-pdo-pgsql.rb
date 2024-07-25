require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74PdoPgsql < AbstractPhp74Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0f9c40cecf265549aee7a8ea60119144515f8ffbfc67d2f7ab14cb802fbc5f4a"
    sha256 cellar: :any_skip_relocation, monterey:       "e5b5ad4e4e28767da4d7cd3dd426a2c2985990be8a26bd533a7aa8520c861b80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6760138070c1a62c7158467d22bb15767fc30e69a03243b3c962ce89fcbde44e"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "6b310ead4e3b61009ca9091b7f1f7128d309ebf95272b3ea5bde4efbda3b4095"
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
