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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7a2ce4b1720a1e829d9a765d5181ae21534d59102095958c4cf3fc12cd3b45d3"
    sha256 cellar: :any_skip_relocation, monterey:      "83ed246df8b2137017910e4a102655ad2038ea2d60a7da73c38d2ca98911d6ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e23ca457ef78b2862e1708fde08329bf17da0e2751968f003e1be2629fac5337"
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
