require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Amqp < AbstractPhp72Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.1.2.tar.gz"
  sha256 "5eebe1d0414af8e4c1e1b5040be68168a533704f09f6f66e4d48ab78edd1d8d2"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d063ec06c7238adc2dd976c0f3c7120f4dd2c7aadcc02c3e42ced5cdf395ee3d"
    sha256 cellar: :any_skip_relocation, monterey:      "637d40cfd8c5e2fa59ffbda6bcf0f2f8f8852a8f6f069d1287f70175b88d4b26"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2e7fe03b3ceadda94c234e28d92716e3ef9ba3a9197f75fc20bf01da12af512f"
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
