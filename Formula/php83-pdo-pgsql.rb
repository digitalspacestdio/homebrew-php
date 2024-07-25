require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83PdoPgsql < AbstractPhp83Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.9-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "86a14d50508d9e7a9071fe9d2210a736861253168ae1d4dd76b945180b4d225e"
    sha256 cellar: :any_skip_relocation, monterey:       "e617e6fc911faf1d73c5374c9f95218d4738ea27e1bc4f46a33b2e90eeaf938f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2788c0a9077449fb283897f897a6cc0d819f853ecfa2932409091feb86662e91"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "5141b846c66a9e44169d69d57c339989b92e8fea60719747b738ec3723fa240b"
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
