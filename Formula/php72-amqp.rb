require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Amqp < AbstractPhp72Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "b74de00674ee2f75a4c31f9af2475b9296d10d06549bdf605ca9d24c19510ca3"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72-amqp"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "589523cd8373bfa75a0d1428f81a9297d9f24c59d4027c24001bfded9c352774"
    sha256 cellar: :any_skip_relocation, monterey:      "23aac54485349eb2f0297494d31f82897f9befcd50b2cb1e91547044bacae8f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d238899cf150e2e06f188b08cfb70ecba3f5d4707aa12d64c0298d0bf0a3c407"
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
