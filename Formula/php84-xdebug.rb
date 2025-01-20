require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Xdebug < AbstractPhp84Extension
  init PHP_VERSION, false
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://github.com/xdebug/xdebug/archive/5107d2d978302323f9e65002fad2aee9f4c24628.tar.gz"
  sha256 "d02d1b61cba9cc018e0fc68dd3bdca33c47d99dd909e56a2f4c114fb101f1ca3"
  head "https://github.com/xdebug/xdebug.git"
  version "3.4.1"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.1-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "773f8da621cd8de38617b9195337a9351cb90e2ab076c1f0c1bab0a790268cff"
    sha256 cellar: :any_skip_relocation, ventura:       "a2fe12047a13c99eac2bfa94590d21a32afaa739f24bd023a41b06f467301761"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "23e1c96839387f054cc319e17eda249c9e7d7acffa20e1f296ab86f473f11bab"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "742c40e5acdcb00dee12b617666de6a0e7aada54208ff5032ebfdd9d1d189e78"
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
