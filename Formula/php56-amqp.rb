require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Amqp < AbstractPhp56Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "b74de00674ee2f75a4c31f9af2475b9296d10d06549bdf605ca9d24c19510ca3"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/5.6.40-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0b86e26c207eba921536eab54d570c0884d289bb8aac7686fb46b97f87860e41"
    sha256 cellar: :any_skip_relocation, monterey:       "0e95604cc74e31c7c9bcc2e71e8ac43a510c33fddee598e689d36554ca185e2b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "852234e5478612bf9fe1015931a4d1af610851203d709318260dd96192fd606e"
  end

  depends_on "pkg-config" => :build
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
