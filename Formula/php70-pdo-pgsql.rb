require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.0.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f78aae75e65f59ab074e985da54c75efeb268f9314562308ebdb994d80660b40"
    sha256 cellar: :any_skip_relocation, monterey:       "0596e3061949f64d36882ee081c88f0bb680c00c12bae2f07b74454f3749fde4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fd8cf90add2eae215f287d2e15d8161e7757dfab6746db43341277c7d04ac728"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "f23a85b2e5b35a55456dcc34b91bdf19c99b4ed915b8ab4b93db435e04d29a62"
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
