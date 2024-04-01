require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80PdoPgsql < AbstractPhp80Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "ff912409e04e5f0b359b1737de103a6dcb96fcafa6cb07de70d3c6fa219fb2e1"
    sha256 cellar: :any_skip_relocation, sonoma:       "ff96324b19f609082cc304bd0f8405baa146a8d1cb7d70e5aa197860b2da7e3e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b1a4bf578179c2428499819f3d2e97d2b93e08888525c3a5ce03366289e5fc09"
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
