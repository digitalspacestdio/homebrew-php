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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a2c90df67f6986fc433ce08234c2e633965034f42fba58f2ce4da827fd02e2f1"
    sha256 cellar: :any_skip_relocation, monterey:      "611eef4393a8e461bad7d9e3aa265fb64f6d64e1e70d7e4f7e1fbca8e7fc55ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0c61ccdca44b8471e63f20fb472062a6e23c91f5470c29b4b693365b53234d03"
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
