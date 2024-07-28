require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Xdebug < AbstractPhp73Extension
  init PHP_VERSION, false
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.1.6.tar.gz"
  sha256 "217e05fbe43940fcbfe18e8f15e3e8ded7dd35926b0bee916782d0fffe8dcc53"
  version "3.1.6"
  revision PHP_REVISION+1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a11e9bf1555b4d6e14b19a405c7fdda53a19793c6d1e188cbe667f938f019e48"
    sha256 cellar: :any_skip_relocation, monterey:       "c0f6481eff6ca561b83ef2c7e606d61aea87a2dde376734ad1dfa01b6887b113"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "04e806a87902c95ec161f7f136d347407916a652ac7fb18a7fbfc142261720ca"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "9b263a624052c9eab1dcaadfd2dbf67b3027a86c6ac117d585e982a6fb0ca196"
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
