require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84PdoPgsql < AbstractPhp84Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0beta5-100"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "777d47189a538aac1835fb889720ea1e5a3885887a70a303506d7fd71cc8f463"
    sha256 cellar: :any_skip_relocation, ventura:        "c10904c398307509edcd5ea2c75e8db219bab75a9071fa7c5365b4444aea6479"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "910031104869e1dc6d01a7d5449e9de0664c1c5145997023f2ccc4667ddb1ba3"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "8df17e48723a833079e15c7c0cc7638ee8e08a58a7264545cdbe554fbae01b78"
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
