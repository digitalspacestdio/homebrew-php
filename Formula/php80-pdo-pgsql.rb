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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ff912409e04e5f0b359b1737de103a6dcb96fcafa6cb07de70d3c6fa219fb2e1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "345a89fb448935d7de63b04d12ab574988cec7f513dc2ea8bf604e8ce87f9557"
    sha256 cellar: :any_skip_relocation, sonoma:        "ff96324b19f609082cc304bd0f8405baa146a8d1cb7d70e5aa197860b2da7e3e"
    sha256 cellar: :any_skip_relocation, monterey:      "f79833147fd3f3023ccb6efa1bedb02a730b6a185859f102b31b478cfe591be8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7bec7c7aebeea5484e012b1b495514a1f9bc901a488a8848551db6cbe191e61a"
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
