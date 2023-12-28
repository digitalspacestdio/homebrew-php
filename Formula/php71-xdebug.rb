require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xdebug < AbstractPhp71Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/2.7.2.tar.gz"
  sha256 "b2aeb55335c5649034fe936abb90f61df175c4f0a0f0b97a219b3559541edfbd"
  version "2.7.2"
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9689a4d054a0c9c9069f165e1bd1fd7d65d8c84833eb531318a50a9164fc183e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "dbd491327db52a9a44aa74d12c07ee9f5c0f667af3d71d6c2f22e644fbdff379"
    sha256 cellar: :any_skip_relocation, sonoma:        "dd904d06ca5c062937052cec9d90cd7adc06f3d65edd7fb8cc0def8859a836ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef767759447fd0349e94387369f0731e3092821087efa0afa86ed4376f8a195d"
  end


  def extension_type
    "zend_extension"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
  end

  def post_install
    write_config_file
  end
end
