require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Amqp < AbstractPhp56Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "b74de00674ee2f75a4c31f9af2475b9296d10d06549bdf605ca9d24c19510ca3"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/5.6.40-104"
    sha256 cellar: :any_skip_relocation, ventura:       "deacf94c6dd025ad8078effc75bf0637b4ec87e1e1731a5f6bffea29b4632311"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "3892044d9d82cf6f4e1dc8242c0887ac616f3030e658fd40cdd8e9cff68e5647"
  end

  depends_on "pkg-config" => :build
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
