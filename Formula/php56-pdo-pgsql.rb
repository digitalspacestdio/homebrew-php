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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9f20042cec0609895971eb753237e7c8d152b4debcc55be9ed303cbc6271d7f6"
    sha256 cellar: :any_skip_relocation, sonoma:        "ee09af8e43b5f5679f5d8fe66c621c614171393c8d6acf3ff2b7ca88e05d2807"
    sha256 cellar: :any_skip_relocation, monterey:      "f9e8a8612334a0963ffb87b9cb98a4cba2d10fe29ac6e6d1eeb8aca0b83f45c3"
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
