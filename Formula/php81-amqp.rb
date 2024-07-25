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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2184fe3eb71f802b12c0e7d90d5d18cd44bd5e2e8a940d37ca49515114b2ef94"
    sha256 cellar: :any_skip_relocation, monterey:       "5f7225394113fe6edabfca884ebebd2b4a3383275122263ed323335342c58de9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "79c4a693798e6109e09254d636eaa8290324584ccb2a395d8ddbbddb8e1fdb81"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "0d5abe60c2220d99a8c6bfacf22c3ef6db223d1ccb67091471717cd962a73b2a"
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
