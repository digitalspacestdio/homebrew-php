require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Amqp < AbstractPhp74Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.1.2.tar.gz"
  sha256 "5eebe1d0414af8e4c1e1b5040be68168a533704f09f6f66e4d48ab78edd1d8d2"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "847438769cd8d94b9ca1ec4fc5a79721686a26aaf0bb8c0f7692e047f775390d"
    sha256 cellar: :any_skip_relocation, monterey:       "9eee22699a370840cc13451b374bac26b266e65acdcbc29a27dce98bee07d33a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "97ca3a5d2ff66acdbf280aa84d9c5f68ff8559b59da369dc693105a653081d81"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "2d77e2393054a8a8da42d076de1c1675d021846cae98b2c5815aaa80058d996a"
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
