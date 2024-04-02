require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Xdebug < AbstractPhp73Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.1.6.tar.gz"
  sha256 "217e05fbe43940fcbfe18e8f15e3e8ded7dd35926b0bee916782d0fffe8dcc53"
  version "3.1.6"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4a05d2958e1db68dc4d113a390c16e6b83f99597df369b2f51fb728900f14570"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0762049a04dc8370e9dc3874e1a4472dccc469d6f033aa5f93f8d58039c1fbb8"
    sha256 cellar: :any_skip_relocation, sonoma:        "4849f48057770e85d9e86c18c9a999285c9712bf7b85ccd7f1e29e62176b30b2"
    sha256 cellar: :any_skip_relocation, monterey:      "3972e73c5f9dca98aaa7a8b22ffbf9e33d4366f45d88d0f008953e4432bc25d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ad13e9dafc2960665c54cbbf8d1f048a5765ab78706f8f16f9669149112ee6ff"
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
    #Dir.chdir "xdebug-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make clean"
    system "make"
    prefix.install "modules/xdebug.so"
    if File.exist?(config_filepath) && build.with?("config-file")
      File.delete config_filepath 
    end
    write_config_file if build.with? "config-file"
  end
end
