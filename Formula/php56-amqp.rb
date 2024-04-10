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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "50d08c95e1990220612441f84390259d52562a5a10cacd925b43038c419763e6"
    sha256 cellar: :any_skip_relocation, sonoma:        "e9b34db3e73bb39836b2fb293ef88e9c1515fbb8e07af4ea6c83176f666bd496"
    sha256 cellar: :any_skip_relocation, monterey:      "2069cb3d523ba301a08bcc93b3504825366dd5b124b8dacf92048dfdd5dfc046"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "90b33b8b0b2f33fce8c680aa16b8877068f405fb2db7093271a41dc13734e71b"
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
