require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "103981915f8392a241d84ad95e525d47a3c79233825703222be9e3a2cc8525ff"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c35f0a2e8cd4ffa59b52029390e63727a5d254c27445519a68b1c47a1d063a3c"
    sha256 cellar: :any_skip_relocation, sonoma:        "203694f8f810b089a37839fe115a4675f5922f39851bdf352ac0a9f0a55edd72"
    sha256 cellar: :any_skip_relocation, monterey:      "66d10504ff6c20356c0f2f7d9bbba47850a8fe89549c58fdc70de262e2330c93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2578cf5c9087abf918ce69776f84691558fae0561782ae85c80ddff93139ad05"
  end

  depends_on "digitalspacestdio/common/libpq@16.2-icu4c.69.1"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["digitalspacestdio/common/libpq@16.2-icu4c.69.1"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
