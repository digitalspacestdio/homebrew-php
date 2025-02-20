require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Amqp < AbstractPhp80Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.1.2.tar.gz"
  sha256 "5eebe1d0414af8e4c1e1b5040be68168a533704f09f6f66e4d48ab78edd1d8d2"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-111"
    sha256 cellar: :any_skip_relocation, ventura:      "cb668cd36cc84c7446f4c5fdb099cf314426f4d31486910278d945e7030ce8b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6f370ba0caff1fcf96f5b99e4a7ece7b0830abd1a76c8c448ce536fdcebfd3e4"
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
