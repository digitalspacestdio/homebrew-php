require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoPgsql < AbstractPhp56Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "31b103cfddd8f6ec515889fd9673fb76268be828174f1189d2005e49793e4a7e"
    sha256 cellar: :any_skip_relocation, sonoma:        "a4a8d0724c8b36be4c2cb4025579629ac312cee94bfd6c1f70686dc05d33ccac"
    sha256 cellar: :any_skip_relocation, monterey:      "ba3b98838f36a1cd3bfd24c5b73bde702ac8d70787dc2bb880703f203c30a6e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "afc9cb0813d151baa0dcfa3bf2fa7121a91b2fb79fe6da7e48b1652216026044"
  end


  depends_on "digitalspacestdio/common/libpq@16.2-icu4c.69.1"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    # ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["digitalspacestdio/common/libpq@16.2-icu4c.69.1"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
