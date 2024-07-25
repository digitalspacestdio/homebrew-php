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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2718da60ec328f1c5c82c90d9dd2ff97b3819b223c841c64f16e034e96451b1c"
    sha256 cellar: :any_skip_relocation, monterey:       "105ea08305c4ee1e53729638f6955880271bad70b1500390ebaeb795e403b4fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eacc299b97b948009c886d1b1a283258e948c73bf7be38c59ec97d32a374d3b0"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "ed7f181ce56f4349a9ad11f75a3d2b50f4e261829bbb6a90f19f09f2272210f8"
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
