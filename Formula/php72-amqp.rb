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
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.2.34-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e52a3722613c03de15ecb69522ca305daacaf5a3dbc86ead5bca65f5d7272c52"
    sha256 cellar: :any_skip_relocation, monterey:       "71afb891dc809d1c397e173417dc8756179865f5bdb94c0e625a254965c5a90c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "227785f9580db13e70687b0a8b4d21c8d0ee59c57fb25b0e648824792f66e11e"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "63c317a40250d525d5ff1615d7b047156dc6fdac41a44514dcc4e7321ede31d3"
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
