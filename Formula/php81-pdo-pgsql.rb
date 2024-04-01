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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5753606a72bcb965cbf742577169ff5aa48fbaeed8e288c82ab43b2e58bca823"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8c54a305a0e5374e5473c1d52916c896a679e30990d49abcca7cdb7eed7ce128"
    sha256 cellar: :any_skip_relocation, sonoma:        "885f8ec07ce3a1dc7354ff94b214177d0324aa4cdb3303aa91a079747e709e31"
    sha256 cellar: :any_skip_relocation, monterey:      "a37d085568e8ce84ca1aeb994f96340f004141002c87453ebd09b18850be8c51"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "486f26fe864dee312e5c1273e010432e31a63441c586c350ee5c5dabd2e8989e"
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
