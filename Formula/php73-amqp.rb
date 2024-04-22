require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Amqp < AbstractPhp73Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "b74de00674ee2f75a4c31f9af2475b9296d10d06549bdf605ca9d24c19510ca3"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e08b327c5fab54392ad799b8211420191907a86f56e75776153567291685d1cd"
    sha256 cellar: :any_skip_relocation, monterey:       "5bc8ddad1a0a1fb69e1933390765455bf4658a7f8b11a9d8c480ccc9a3f50fb4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8a169e703389b6a7214e2a9735eabd99990aca684565e969b43b96f80e4f7913"
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
