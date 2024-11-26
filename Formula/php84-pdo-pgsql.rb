require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84PdoPgsql < AbstractPhp84Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.1-106"
    sha256 cellar: :any_skip_relocation, ventura:       "0b8c14698f52dc0dd3b6f98e43afdbcc0abbc245006abd73f11ce22c2e19998b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "76d526071249c5f7c324df11aa57728639bc3b2a884132f0b5c1fd946ee56644"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "fc120845cc55510da72d0b0f8724a9c900b8816bf9479e21280021fe697bd525"
  end

  depends_on "digitalspacestdio/common/libpq@16.2-icu4c.74.2"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["digitalspacestdio/common/libpq@16.2-icu4c.74.2"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
