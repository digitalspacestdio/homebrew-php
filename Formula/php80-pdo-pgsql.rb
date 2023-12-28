require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80PdoPgsql < AbstractPhp80Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 21


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b627eb864a52f53c1bc8469bcff4c5e4084c6919cbf9fb3332ac80f5ce4f8a95"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9e4c65b42a97199b9b1e1dac8acc3a04076d53258c33dc0b8aec0aad46a0cdae"
    sha256 cellar: :any_skip_relocation, sonoma:        "939321c551db02fe509b93f15c73d25324630bc23ca2579e67f743d429729ee8"
    sha256 cellar: :any_skip_relocation, ventura:       "93f6b00d84b6e2523762b774d1af673a6b27939a32ab17589cb4d39dd2fab2bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "360e02d843bba742b6ff7b5678b4e780828110a081886209aa0d5d2adceee715"
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
