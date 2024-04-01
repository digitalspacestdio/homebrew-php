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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0f17f7186132362ef4d527bcba9239e4b092cace9764d352f5ac7fc8353dc933"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "36ff0c89d12c63a7e2f94e6825f5a9e3619932273711800bfdf3936e465df65d"
    sha256 cellar: :any_skip_relocation, sonoma:        "d1e04da435be5b2308895da6b9e0199d3688e4ffb508a3298ec6803ef8bdf8c3"
    sha256 cellar: :any_skip_relocation, monterey:      "2c0b882e0d301958d6f71dfbda78e6936896c9dfa5ee6b5ddaa106a4e24917b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bf6de6b01849d5c121fd70579ef4366ca88ca511136583ac8a5c0da9678fc893"
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
