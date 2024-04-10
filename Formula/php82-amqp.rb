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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "77b0c87e2a9464786820a2ce7b4b3fe9a42698c4f1a3f949badcb06e8e895fab"
    sha256 cellar: :any_skip_relocation, monterey:      "aa207f93e2652f83bdc29441e128af1a02cdcfda70fa4f2394a3758f677a70d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "360425f2b032ef14a8edee5b17610cbed033fdbdc0d844f579ddfd0a43983c21"
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
