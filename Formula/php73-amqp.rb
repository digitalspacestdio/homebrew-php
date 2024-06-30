require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Amqp < AbstractPhp73Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "b74de00674ee2f75a4c31f9af2475b9296d10d06549bdf605ca9d24c19510ca3"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dfad5ca27821483ff361d3636961810e7a78495eee7d1d034703234e9cde8df4"
    sha256 cellar: :any_skip_relocation, monterey:       "935480e3800fb235bcdd42a96ac816e9f0b8b978088228790ba42a8e98930dda"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9a94f29382b60d6ad54fef8f6d28d0a1fff2121e77fca6e6ede1f8697ce69f2d"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "88e68c69cbab85eeffe8d23c47f0c52fa191dc50209e07657f7e35a0ad8d920d"
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
