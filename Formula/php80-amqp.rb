require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Amqp < AbstractPhp80Extension
  init
  desc "PHP extension to communicate with any AMQP compliant server."
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.1.2.tar.gz"
  sha256 "5eebe1d0414af8e4c1e1b5040be68168a533704f09f6f66e4d48ab78edd1d8d2"
  head "https://github.com/pdezwart/php-amqp.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "10ed79ecf47a213c521653f888da076ff0f80372ae95769b87e06b79fcae8554"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c8e8588f949b161b9d1117766141f2d37f89638a2e67c1550c5ca2a7e2402cfa"
    sha256 cellar: :any_skip_relocation, monterey:       "078062dccc5f9c110a01dd06afbccc6bce938790b2e29a21c03c3119c7d0adb9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ca1e98e42b4b3092b537c75a5bcbd7a0c8da01a6d66d31cc3ce42ddd108fc80b"
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
