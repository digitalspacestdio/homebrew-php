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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "56de19afbecc4bb1c12da939b7eb7c59a12b1a8876bfafec51ba1acaef63868b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a0a294736fbef96ecae29721d12343cf58f0add92ac3ae50920c40e5a409757f"
    sha256 cellar: :any_skip_relocation, monterey:       "76ef7b77eb512d19f90ce35e0b98282ab320059972d679504e6bea540e05de8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "118f3a3fcbc2b79b8f460fc8691550dd33ada69072ae76ba9b318e4ea9c4a1ac"
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
