require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Xdebug < AbstractPhp81Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.2.2.tar.gz"
  sha256 "505b7b3bf5f47d1b72d18f064a8becb6854b8574195ca472e6f8da00bdc951a8"
  version "3.2.2"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "64762003dd8a87dd222ffffbce512ddf994beb21e3ef33d9d6872c8bc68bfdcb"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d1d3f8baa6f7125f51b01873da2a5d666ceba35574dc446e14cbe8d12c151dce"
    sha256 cellar: :any_skip_relocation, sonoma:        "766573f3119f783ca58f0cb2e20996244460fd6de2cadad5b3d5359262eac451"
    sha256 cellar: :any_skip_relocation, monterey:      "5e436b1a63ebe82562a89d4c3eabdd09b72a5cd69e5d6a0b4fed2ab001e5fde9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "944b1bdcb166455ac77ccba19d357593317d997a662e3829f6d198db7b41c7e6"
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
