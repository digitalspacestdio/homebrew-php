require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Xdebug < AbstractPhp81Extension
  init PHP_VERSION, false
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.2.2.tar.gz"
  sha256 "505b7b3bf5f47d1b72d18f064a8becb6854b8574195ca472e6f8da00bdc951a8"
  version "3.2.2"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c689ba9ebd8e3e2f0e4c9fbe31c5b8df23217e5a73399739eebb0d7113f6a2fe"
    sha256 cellar: :any_skip_relocation, monterey:       "7f6b8ebf70d9fcfc69286492e7c18ebda5fe6e44723576a6633a34b3b0f85e15"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3bdc61023dfb7b1e924dbd86cfe76aa15b6e52e8e65eeb1e8b16134cd3698b08"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "0f4b6a7de32a41251532fd239708bb6ba7a21f248f0d3f3375d18bcff3641042"
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
