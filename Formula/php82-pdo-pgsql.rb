require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82PdoPgsql < AbstractPhp82Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0155cd51d787428b3b711bfdb3e62f41db4912983d80fd59639eddc47fb001e1"
    sha256 cellar: :any_skip_relocation, monterey:       "f62b52db550eeaab274f2eb32162836286a3e9c7bd9a3a4ec1c049433f62611c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7505248976adba6c2f3fe8a7c6cca470b4c58b84912939c6524cbe4e6d485c91"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "b6689f957a473414f65ed5a5a517673a5a3563aeb358335e3aaf2a8d0ac5d063"
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
