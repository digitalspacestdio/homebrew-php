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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "51ebcc3317e0474792bf6ea940b550cadb96191c06ade7d575c67a304bdfc41a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9bf35c69dd219f4f8a8016d4b27686d02b21d60c30752df30464e55ccaa717b2"
    sha256 cellar: :any_skip_relocation, sonoma:        "72b0c86f072c0eb651fd05c2c68d6ac3a1ba496bc726a13814b8c0a421b753df"
    sha256 cellar: :any_skip_relocation, monterey:      "a7aaeff1f940fa468d81176f333ac65d516d9bda2209d9e209f5bb636a834176"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e4d01cf2f5cdec62c1277fe6891bb9f1b1c6ff6feb4a576ab93300aca1b9672f"
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
