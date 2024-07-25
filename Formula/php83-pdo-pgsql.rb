require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83PdoPgsql < AbstractPhp83Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.3.8-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a1805c9a3f2879397cf7cbeb6323ad86c430818c0bf399f3be4001c59a712350"
    sha256 cellar: :any_skip_relocation, monterey:       "a7ba77d64fabf22664c9c555a4af86af4b1ada7d285057570c037e4af431210c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "799acc9e3e642f685e3e48dfda2962274a248bdb06578d0196fbd2e572baca94"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "662453ffcb4bf6c9288ebaf705a68a0eed62c2c77523e91cb03e000c75a7a98e"
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
