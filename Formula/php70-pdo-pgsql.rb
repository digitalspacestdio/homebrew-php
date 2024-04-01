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
    sha256 cellar: :any_skip_relocation, sonoma:        "bf812dee52a48bdf8493dd40b2625beb33c782fcccea0b60c4ebf1206ef90bcf"
    sha256 cellar: :any_skip_relocation, monterey:      "41f3634399d7acba8760a59fead053aba4c77a462611f64e3a1ea7cb193e1fab"
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
