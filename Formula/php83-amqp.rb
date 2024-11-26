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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.14-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "fd7312942ec58ad67b6efa4d9313ed761320c019e8a41395cfd39776455a6efd"
    sha256 cellar: :any_skip_relocation, ventura:       "f63d102b1c5def0fb79dcd7f8162cc406cab1e300cdf4b2e062605c0dda55a27"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5b8b8c6c0fc54d3bb265dc5eafcb6db1f4175db2debc6c22aa91e3500d929994"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "97fdd851a0ffba996bd3161890e4c8ea75aba63fa2ef1ad34c66cf6e9824f78a"
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
