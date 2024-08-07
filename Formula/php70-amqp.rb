require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Amqp < AbstractPhp70Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "b74de00674ee2f75a4c31f9af2475b9296d10d06549bdf605ca9d24c19510ca3"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e1b46b23cee0ee738476bb7e79b78c0409cde68b9ed7cde842cd69fe586972cc"
    sha256 cellar: :any_skip_relocation, monterey:       "aa6211a56f4682565c111cdc25051a9b69db2c84f9451fe1641a0059976b7da3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c46272b9ef10e6ce1bc59a5dce35cb642496c07395fdffab639ab32a16450370"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "766d6e0ea5a02c9d24b7c0c8a54da49459ccc7f4bb37141c0efb774ffc0e8d2f"
  end

  depends_on "rabbitmq-c"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-amqp=#{Formula["rabbitmq-c"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/amqp.so"
    write_config_file if build.with? "config-file"
  end
end
