require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Amqp < AbstractPhp70Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "b74de00674ee2f75a4c31f9af2475b9296d10d06549bdf605ca9d24c19510ca3"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "73f6b89e68efd66bfb539f9b4c61822e2c20659c128dd59564419db7acffe409"
    sha256 cellar: :any_skip_relocation, ventura:       "1d9bb39ef6f046489791d4b9c0c41c754f1b05eec511621bf722ec9782d0615e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c9dc16109e8c04cec00ecc8cb36b7f433d74cc1492fd52704c99cb2d5b1ecb0"
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
