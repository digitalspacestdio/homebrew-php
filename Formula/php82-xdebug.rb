require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Xdebug < AbstractPhp82Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.2.2.tar.gz"
  sha256 "505b7b3bf5f47d1b72d18f064a8becb6854b8574195ca472e6f8da00bdc951a8"
  version "3.2.2"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "66c03afb4ecfdebafe695ea656603efed36fac6eb1b773f5dddb44e5b86d2d6e"
    sha256 cellar: :any_skip_relocation, sonoma:        "006f79a69e5878a4b4431b07a0f59e49e259f1b1a892075908b5647e0454b2d5"
    sha256 cellar: :any_skip_relocation, monterey:      "4b2264b9494b5f7a25cb83f29e7f46f5e63d94b3d3f4d2a40e6d89380653d651"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "86e7a11ff4724f4e7a5e597dbef5863469e879d7be557118f35115d513958a14"
  end

  def extension_type
    "zend_extension"
  end

  def config_file
    <<~EOS
      [#{extension}]
      #{extension_type}="#{module_path}"
      xdebug.mode=off
      xdebug.start_with_request=trigger
      xdebug.client_host=127.0.0.1
      xdebug.client_port=9003
      xdebug.discover_client_host=false
      xdebug.remote_cookie_expire_time = 3600
      xdebug.idekey=PHPSTORM
      xdebug.max_nesting_level=512
    EOS
  rescue StandardError
    nil
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make clean"
    system "make"
    prefix.install "modules/xdebug.so"
  end

  def post_install
    write_config_file
  end
end
