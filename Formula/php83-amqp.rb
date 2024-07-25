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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.9-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7dec5512de30ad9a63522be00f3266b72c2b5c01064876689f3b0e8b13b4ff6f"
    sha256 cellar: :any_skip_relocation, monterey:       "36c209e961a31e9e42ed197405022f89c5f28b4c7f80bf42d390a627ddc0667d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fd9da097017e6299db9834c34ce78f23b1ff893107285bc4e609c07a42f901df"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "7e0aae21e1f8d405272c5c8a3aaf8b0c756592df37686cd4851b7fe4b69fe4c6"
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
