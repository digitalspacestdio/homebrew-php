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
    sha256 cellar: :any_skip_relocation, monterey:     "98e19afc275f46ba06b507dbaa44f7b43af7dcc316990283f19cabb3857a9d1d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0a0e16f53a23a2e1635a395631cc7de2340877e03a7e4ec12549b06d9be28327"
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
