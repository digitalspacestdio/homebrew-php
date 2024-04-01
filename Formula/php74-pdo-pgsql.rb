require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74PdoPgsql < AbstractPhp74Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "69aa51b6405fb6095fe6372da688789c6fcf01f37c530f8f97ddb45e2c110107"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5aa7b2e48b5eec4bc1cfcac33aa6e4b5180b0a8dc77e5281af5d80d209a1fb89"
    sha256 cellar: :any_skip_relocation, monterey:      "f30dff1b37329556beca26bf3b3e805e6f5ebf086b9829d30527025ea86fea00"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b2275ee7016765ba805c7e45f07709ad6665f9709168086de131ad11138ec043"
  end

  depends_on "digitalspacestdio/common/libpq@16.2-icu4c.73.2"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["digitalspacestdio/common/libpq@16.2-icu4c.73.2"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
