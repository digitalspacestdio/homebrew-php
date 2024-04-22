require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "9ff0a83695d2e72c045692be592aab09c99c9f0943f797fe228323316989a4a6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "be62077aefef4d1be410e03dbf4e050994bda45aac4200a9c2490edeb10a8bf1"
    sha256 cellar: :any_skip_relocation, monterey:       "a2d97e482eb8e6edb40cf0e7d58ce6a065f46eaf172a6f04978fb9c7573f828f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5dc3b1a842907e7cbb0e4f6a4723fe8a75f5317ef19dc9e4eb601c19dddebfc3"
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
