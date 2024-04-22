require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ab4f3f201e0ceb12b893e2eed9fbcf5c20e8c020b01fd77bd20aaa6df7dab5ba"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f18684f73c42df53ab212c5dec87a6cd4868c6c9040cf218a7419c4873b0ae4a"
    sha256 cellar: :any_skip_relocation, monterey:       "a088fa546a5e8cf7345d90d42d2137e66a3d37b3ce1fae44e7ffb0f605ff1a36"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "81523d350faec45b643ff46812c1ebdb60dfcaa502c78bf19c3697b9228b2100"
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
