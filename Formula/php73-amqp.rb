require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Amqp < AbstractPhp73Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.1.2.tar.gz"
  sha256 "5eebe1d0414af8e4c1e1b5040be68168a533704f09f6f66e4d48ab78edd1d8d2"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3267253b94468bb72cbbf8034b32933f19a150162e0df27ced62adbc137b2400"
    sha256 cellar: :any_skip_relocation, monterey:      "931aa12c22e138baeb085639622baae9cbc9e95e3f3bc34f44095e5f3002135e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cb5dd64beaea847d676a6c7c8af5ec32f03d617c81d3c31f44f1bae701104f47"
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
