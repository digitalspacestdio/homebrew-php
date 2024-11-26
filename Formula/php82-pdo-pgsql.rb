require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82PdoPgsql < AbstractPhp82Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.26-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "03fe88809c1ed7f9f4048d0c69a3b80fd1caa02878584bbf91af7103b21e2515"
    sha256 cellar: :any_skip_relocation, ventura:       "8da0f97859077b34a314dfbc48d3cf139e45f3cb06105cfe79bac9d9bc11a533"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "37ade7b8812dffca6d49761ddc5757cfd01b41d741e640346f070e2bce84c9ef"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "325456afb966285d24b06063a122dcfd731df96c7456db76b25a4a6e1bbaf060"
  end

  depends_on "digitalspacestdio/common/libpq@16.2-icu4c.74.2"
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
