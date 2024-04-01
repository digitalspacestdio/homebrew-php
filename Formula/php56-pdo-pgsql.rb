require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoPgsql < AbstractPhp56Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b9ece62733d78c36cc30ff91d6595f3a8b1ed7357e8569333da5e12047dc4343"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "23bae970e27e888e7451e3e23dafb79f7d62180cf3754ba7351b5a8c95efe7f3"
    sha256 cellar: :any_skip_relocation, sonoma:        "623470ebd05e7ec5d4d09f84f38a138d4d0f81f85e4844cf4f79600efd46cd42"
    sha256 cellar: :any_skip_relocation, monterey:      "db3b62fb3ebd73e8eea75d9be86aa045f6c7048a1e612d6fb99d0e896958457a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "75f8976e71d657afb5b02946da461e29bd189e9c3b339762ee864e0d5fe0f9c6"
  end


  depends_on "digitalspacestdio/common/libpq@16.2-icu4c.69.1"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    # ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["digitalspacestdio/common/libpq@16.2-icu4c.69.1"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
