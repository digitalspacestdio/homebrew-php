require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6a394c42b1545fe9c78f62f97a3abffdce8ad5f25109bd7eaddd078f761ec5fc"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a7197bebc7d5b5d977f14e771dfbc16630da86803d3336b961e80b6303314ee0"
    sha256 cellar: :any_skip_relocation, sonoma:        "d3276ebe6a5f0f20ffa3f08de9ec2beed395893cffcf50ae960952f4646cfaa0"
    sha256 cellar: :any_skip_relocation, monterey:      "66d10504ff6c20356c0f2f7d9bbba47850a8fe89549c58fdc70de262e2330c93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2578cf5c9087abf918ce69776f84691558fae0561782ae85c80ddff93139ad05"
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
