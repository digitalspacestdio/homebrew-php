require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82PdoPgsql < AbstractPhp82Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4ed970a2697d82b4e6cd8d82d025bda2c8a01d02af491b1b1a0936eaf22dde1d"
    sha256 cellar: :any_skip_relocation, sonoma:        "1c0c6ffa6c5f97c064fcb1305f7d2ba36bda775d8ba81d4db20c7a0a47a483f2"
    sha256 cellar: :any_skip_relocation, monterey:      "ac8caf5fd336e72315e767d37d5e153c4d0e8ec8b9a402027121bc51735a8c21"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a65b8e7013274729e723e0f11e07bfcc49298dcf09512416154414c119bb1eed"
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
