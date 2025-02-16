require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Amqp < AbstractPhp71Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "b74de00674ee2f75a4c31f9af2475b9296d10d06549bdf605ca9d24c19510ca3"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-104"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "debd581f7517576b3aaa54b9de1d242ca802de7d95d0cf7c6b17e38363b2762b"
    sha256 cellar: :any_skip_relocation, ventura:       "5586f59f8537d368794e6b59d4333d61feeb3b761c466f24bbc4a14aebb02e3b"
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
