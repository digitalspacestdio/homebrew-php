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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bb962d000c6ba7c78ff8a80d713ec30896f61da5646b3aebc948e74cb80bd89c"
    sha256 cellar: :any_skip_relocation, sonoma:        "e3a852cc317064ecc7a4ce8d18164ccf1a4df13d3e428fc3648511a9abadfd37"
    sha256 cellar: :any_skip_relocation, monterey:      "53506c8fa366f6ba981e1d6a5b14adeca2cfdeeb38f78f23990a91f405f3dfd1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dcbde018571702781915b44c200cdee6250aa31e45b67f8aa16b7f9a7d44fae9"
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
