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
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "27a785c4d9458c86c0eed4f5b1869a2120f4797c92cbda69044e514eb71642d7"
    sha256 cellar: :any_skip_relocation, monterey:       "77dc3738ceba00dd8d802a3cb174514b3e881dd6d7218bca961ad489bc91a53d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ffc9a32739ce2c8c7ce5f7eb000586997801b2edbf53a6aac387096699d7d51a"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "125afb91dbb73904176fe4f4e5d12db3aaf0974efe8e466150bff552112a9466"
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
