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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0dae9f172f89d7e7a248ddd421abdf5cc64a84a06e58abc9838c2dccc9066b2a"
    sha256 cellar: :any_skip_relocation, monterey:       "28a00554558bab1a2c9c2aae9ccaa54b5aa785ab5661ef53952f99f3228d63e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "046366f62b2e755f16918af23cc00c244accac4744d75b27659bf12c99fc805b"
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
