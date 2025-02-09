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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.26-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0565682f4a7d874b696cf4d657ab986effdeee365447b9688dc1f2e45886943e"
    sha256 cellar: :any_skip_relocation, ventura:       "78744562d07799f2d01b4d574925fd078197fa96a39adc97c00c1c6e86b3d1d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "99c23d86e6e759516fccac00556cb5b5f1272800fa9d1d0e9ab716273cf3e318"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "bdbc6639d5aa63f34219051986aecbc7a0f63593ac68e3094c8ce11f2e399b29"
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
