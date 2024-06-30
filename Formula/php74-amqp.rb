require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Amqp < AbstractPhp74Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.1.2.tar.gz"
  sha256 "5eebe1d0414af8e4c1e1b5040be68168a533704f09f6f66e4d48ab78edd1d8d2"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.4.33-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ff55d1b7e855812cbd06fe4c94bef6b9a6f2189fd15f3000041987dbe0ce7ed2"
    sha256 cellar: :any_skip_relocation, monterey:       "59005f37a41c82956fa51b671ba69b914b4fae101af47ab6075f9ddfef17ea8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2572155d3f04c0dce1e38639c766b8f61e7a2fac20c4212165d6b1affad37002"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "0b53ce9c7794f48d8d57a143c83fd916e5d88d73083139c20a56b3b0d997da08"
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
