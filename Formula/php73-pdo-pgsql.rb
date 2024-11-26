require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73PdoPgsql < AbstractPhp73Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "614c3585b8c8eab34334f3ee010e0b65d275da570384e19deb6c325aa0e6df74"
    sha256 cellar: :any_skip_relocation, monterey:       "f15c60787fc04e0316e72177fad0000a9a8a728ecd2871de85b052e8a20759f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6d39e5ce61f26782057b8fa31526472a9871e8e21b282252fc6d92d11422f8ac"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "2bd4e911ddd40be3320df04c59b9a29c4fff031ba2c81a6a7cb273fb47241d3b"
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
