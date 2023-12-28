require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74PdoPgsql < AbstractPhp74Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 21


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "133dd45ba2a79e9df08c6f13b85fc4873d5395c838ff82e40a6a2ae68d204940"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3a2eedce49acdb9b7c416e4925c49e5fa5741efce8060fd8a66ca6f0b52be40f"
    sha256 cellar: :any_skip_relocation, sonoma:        "397c91710a205f2277c79d2216ae772a09cd1c306b88d6669f897ca5711ce575"
    sha256 cellar: :any_skip_relocation, ventura:       "80cc1a9bdd2ef6ece1e8dd981d9946d1cdf91d165d8b1f7f8c032935b9f3f98f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c568f009b690195c0e3be20c567b8b1e7dbd5ece050b13985ec0951541ba451f"
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
