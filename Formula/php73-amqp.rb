require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Amqp < AbstractPhp73Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "b74de00674ee2f75a4c31f9af2475b9296d10d06549bdf605ca9d24c19510ca3"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-111"
    sha256 cellar: :any_skip_relocation, ventura:      "cc569c7376d34dd1a138a9996dc8fff47b5bb7df858a7fd41169cde112e25b8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bb158c2cf6ff5bd4d103b0b7612a21cba5044a9b059ead29aa6b9f25cdac5842"
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
