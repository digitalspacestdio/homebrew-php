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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6c1e5411db8d43771cb1d180466bc45a484727bf04dd4843ed3b2ddee57e8ea9"
    sha256 cellar: :any_skip_relocation, monterey:       "736e0008a671a26b6bd65b28962dd2c4cfcbc778a4ac6a9bc53c3ef42c7cdf69"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1a76b9615191b370fc7b6d77b4a1ba2a2f89872c3fcdbb6662a7b790dc07c875"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "89a0444bfc21d208f208d8bc8e109fd8f6e1b48c74535b8856fa4b9bf8ffd510"
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
