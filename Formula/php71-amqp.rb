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
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "286b1c129f2733b6157c75e5f7332ce7cecab5eb91e2be412ff18e4fc9598296"
    sha256 cellar: :any_skip_relocation, monterey:       "3f4e9e4770a5fa88c07f9cfda5fb42d2b165d546e4f8e6b9943fa68b1d220ac7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4b450dd945eeb939781798268296835740d4d49ff1bbec7a8f5db88f50ff7b3d"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "573524b0da74d627d855741f546a832e9188e3d9d7d18c6034c6c9da3febebcb"
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
