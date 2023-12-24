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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0519a549bb6dbc52a80af63f6a7bc205233acbd34eac8d571305a40fbdda7d54"
    sha256 cellar: :any_skip_relocation, ventura:       "93f6b00d84b6e2523762b774d1af673a6b27939a32ab17589cb4d39dd2fab2bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bcb4d51c5bfabec9c6a7479d78b559256651e6c90f5b768fec494c1eb018f7af"
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
