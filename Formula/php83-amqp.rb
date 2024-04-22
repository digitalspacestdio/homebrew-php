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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "adf51ddbd7fb686f341c72c858f4c8e467e1b3f0d4c4244c75a00398db3252ab"
    sha256 cellar: :any_skip_relocation, monterey:       "9819adf4cf3df2a7da82b6421e05b12b04da5ea647efe0527a1e1ff05d500efc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a0bf63a955fa31623925122a28e2940336fe16f7256276e6a220b12b1dedebe3"
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
