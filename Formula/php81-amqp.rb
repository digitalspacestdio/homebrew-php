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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "17444f6b5eb3177478005b59d5e5906276419e46aee00fb10d56a68d2cb83876"
    sha256 cellar: :any_skip_relocation, monterey:      "25d0a4591a5f81e053802fd832653eda7e94ed8462082e1f0d901931b6ef3039"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fafdcc8bf52f4a4a1ddd3e6b2779148dabb80346071dff7a30c07fa500699e43"
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
