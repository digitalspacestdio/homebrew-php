require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72PdoPgsql < AbstractPhp72Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 21


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5cb4ed0ab3ee4bd7be48cb65216e0c887f15b585ddc42dfd8a16209c76864bd4"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ce7c9a18f6330919836f5555e99acb6207c91a31e99f083e41b1c7bd53dcfc0a"
    sha256 cellar: :any_skip_relocation, sonoma:        "c1f3792f69dde4e5b0988bf66ccbd463e1198e039cbef1a2cde3d4862e975352"
    sha256 cellar: :any_skip_relocation, ventura:       "f2e865d72f1a448f4f03981aab55f0e2a65cf248fcfa82d988c4e8b60bb2176c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6c41e557471e68432cb3dc5929f5058b0b1a10a7fae5b670c21d29528c667a12"
  end

  depends_on "libpq"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["libpq"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
