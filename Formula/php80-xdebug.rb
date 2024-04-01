require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Xdebug < AbstractPhp80Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.2.2.tar.gz"
  sha256 "505b7b3bf5f47d1b72d18f064a8becb6854b8574195ca472e6f8da00bdc951a8"
  version "3.2.2"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cb5f94115d4dd1846bb2cf91b1316f2a51c0bce7fe094f4379ea035d5e211826"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1de5589f2453568f65f91682a18d8c2b0b0d28f424848a96bfb6a9350b0380fa"
    sha256 cellar: :any_skip_relocation, sonoma:        "d1957c0b78f7add6476fb86d38eb489f07f6e92e93fb1ab9fe56c3bb91497df1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1c8368907a8a12b9faf9b2e8c8e178c87f1dcebb02ab46ec3e9739271903e315"
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
