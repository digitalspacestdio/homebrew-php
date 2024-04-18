require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Amqp < AbstractPhp83Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.1.2.tar.gz"
  sha256 "5eebe1d0414af8e4c1e1b5040be68168a533704f09f6f66e4d48ab78edd1d8d2"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4981182d2f24c195206858b93148d272a03dc1457b5c30ad1edde56c95186623"
    sha256 cellar: :any_skip_relocation, monterey:      "800b66fe4ab846c3938996e8330bca01b81b5459409e34bde0b7cc889c5d8e7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cbd7bcfa002a2d8fbaabc5cd721fedee581b961ab3db03e8522854beb11a53c0"
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
