require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Xdebug < AbstractPhp74Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.1.6.tar.gz"
  sha256 "217e05fbe43940fcbfe18e8f15e3e8ded7dd35926b0bee916782d0fffe8dcc53"
  version "3.1.6"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "db5d4bb082fb1f9d10e875e9e91fd2236e7002324c2b717234e4a0d0d928ea19"
    sha256 cellar: :any_skip_relocation, monterey:       "717d4662cdc6abd1d047a202ddae69243bd0498b5b5c9db5ad38a23127b6f98e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "35b5dbf45c5386d82d9d420ee9ba5d4ec6ef6b3934537673fcced7f779f83b6b"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "cc8adfb6ffce747c6d265cfdcf05a5d9cf9741dcfefaec7ec3d2b14d3993554d"
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
