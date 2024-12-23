require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Amqp < AbstractPhp84Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.1.2.tar.gz"
  sha256 "5eebe1d0414af8e4c1e1b5040be68168a533704f09f6f66e4d48ab78edd1d8d2"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.1-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "50d5a2103dc280842c1a2584c4e57cd216197a9b5a8d6dde53fe574dc46c2df5"
    sha256 cellar: :any_skip_relocation, ventura:       "063d6c79ad48d31bd797b3044aa65efc5cd84a5b7dde740b6d16b5e4999b9e13"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b95e431ebe0ef4c968badf148504e417f3a8465a719ae18c9a70f65bfb627e04"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "5f345e4167de22a921620ef19aa6fe0f61c8e25dad0f8ff4b0d2ac886e71fc03"
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
