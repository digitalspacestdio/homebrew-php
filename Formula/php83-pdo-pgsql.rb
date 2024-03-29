require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83PdoPgsql < AbstractPhp83Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "766a8365793801696ff98edf0e39ec89f21b896f60736d6c1f7fd1baa1805f71"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "57725c7a1d7c7bcd89aa0d1a0892e31e66c76a5eb265cfcfc1e0ab55b0ffc77e"
    sha256 cellar: :any_skip_relocation, sonoma:        "f2c8c961455498eedf1aa6aab14887e98446c2898ff0f4a95b4470dc08639fa2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9211751d9330d411f2173f5930231c4c45e0a86547326373c411ff50d5131a63"
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
