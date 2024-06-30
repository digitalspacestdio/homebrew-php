require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Amqp < AbstractPhp82Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.1.2.tar.gz"
  sha256 "5eebe1d0414af8e4c1e1b5040be68168a533704f09f6f66e4d48ab78edd1d8d2"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.2.20-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8494ed5efce268ce8a2f4e063d1f5e732ec39aa9d5e0b1335b4ebd2e89d3bc0c"
    sha256 cellar: :any_skip_relocation, monterey:       "15544fe0e6024991db87952f0e93c7806d33df3414a87939b20216077e53b7dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "682a1b6d32a524eb7ff9a881d65f90f4a4915a90da105d4d8701c726b897825a"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "cd5fbd4511048bad68b3dd366775e4a290be8106d7a664de8b4ace0d8ab4d0ff"
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
