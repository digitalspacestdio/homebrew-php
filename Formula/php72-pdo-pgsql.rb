require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bcb5f8ee57f09e44d1794ffcd79ad1cb226c7e747fa4b9e7a5fcb6132ea004ca"
    sha256 cellar: :any_skip_relocation, monterey:       "ac7f685a4e10cf1b7f1739940c2d7ad90a8752b49f36facac4b6995cdc0d29ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b32a6320fb19d33438cb5a73e41cc80ebc6037e1a013d593d89a13aa61ccb45d"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "03f5200f71b86c3f91a6a038a44c05783d307aed732acd5db0a2eda38d0eb544"
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
