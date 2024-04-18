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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f5ffcdc118374f012c91e31bdf8690fd7d3093eb25e3f78c15a17a70a6864101"
    sha256 cellar: :any_skip_relocation, monterey:      "8602747705000cd21f96e538e15e1327a13eff0f84931370d5593a3460b1feec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "921937c298e817f8994d388c93f61971ce706a778c3dc3ce734474065d9df7b6"
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
