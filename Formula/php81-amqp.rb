require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Amqp < AbstractPhp81Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.1.2.tar.gz"
  sha256 "5eebe1d0414af8e4c1e1b5040be68168a533704f09f6f66e4d48ab78edd1d8d2"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cc8be1e36e6df8bbdeefb7388e2e8e86aa81dfabc8f73aaf79ba4da761e2b42f"
    sha256 cellar: :any_skip_relocation, monterey:      "20dfaa9b8fb07fa1d01510207c959830f0114e33dc1c91ce110983bb653ebd91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0762fb1d42ec852694b372871adfdb30a2dba813ba8f518992797177eee3191c"
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
