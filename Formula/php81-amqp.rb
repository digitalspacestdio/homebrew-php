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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ca3ccb4839fd6ddcba8b9167ce30569fa200f035fa824b9069ccb5fe372a4c3c"
    sha256 cellar: :any_skip_relocation, ventura:       "90a2ce4cd82af2501c11290b3f05c14709771ddab8e14c0bedc5d368a061dfdd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3ab76581999b6f03a17b208ac76a49262e75b99de9b1b65884ed17961fddc6a6"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "4f4383b1a41423d7e1903573ad030a2a3f81b08ffd0f7e2f549c13ac30453a42"
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
