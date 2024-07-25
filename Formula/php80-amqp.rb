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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c3244613288a7b9da6ec614fdb14e442b24fa78676265fd74422397ee8de64b3"
    sha256 cellar: :any_skip_relocation, monterey:       "0a8f95a7c0dcdff88c3be687169a288e6649bafeca03d0aac7a122aac61de198"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "be2baee89217dfa52893744b005ea75ed9ea08d10a53cb19bfa4bcb8e06d83b2"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "a58b1ff9b80fdec9544242d2455691f23e79db23202e135e2c3a57e2e550f729"
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
