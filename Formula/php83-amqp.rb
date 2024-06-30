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
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.3.8-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9fa02a233a9d8f3b91f4906098139718660ef3dfbca2cdd1c6cccb7d31c6f487"
    sha256 cellar: :any_skip_relocation, monterey:       "e51e08a4d3b1c141cf53237e2a60bbac5adc79794ac8b117004f5748c0fd6c05"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7e92e3fd4465771e4bbeeff8e69438bdd2f8ae48ce1555581dc89c333c2bf3da"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "7d2a73ad534313ac45e1804b90bbc342a9d2e1ecca47c4e8da0c6a3d9b7dd194"
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
