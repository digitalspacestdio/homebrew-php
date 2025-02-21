require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Amqp < AbstractPhp71Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "b74de00674ee2f75a4c31f9af2475b9296d10d06549bdf605ca9d24c19510ca3"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9a72dfd1010a8929e22e9285e00a31bf0fccd587a01994b79b6939735bd98d47"
    sha256 cellar: :any_skip_relocation, ventura:       "729cca09870e64315d1d62353b7dc31fd05f0b6626388269ccc0a9491d503c05"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a30cbdeb4eacd75b50b12e15de4d21c28f788617382e1db2ad69219788576e0d"
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
