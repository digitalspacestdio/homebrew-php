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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "26dd174cd747760640545676772bf05f00f6509a4dc782ac7850585162290fc3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0fff453fccadbe3175436d5e0c0f3d11e69e8804db593531dfa132142a33d49b"
    sha256 cellar: :any_skip_relocation, sonoma:        "69264abb8bb53ba571604b76ab7d3969e4297ffa154615542dc7ba688a94b04f"
    sha256 cellar: :any_skip_relocation, monterey:      "9a81059bd043bedcf683d827612305abfc52daf9f7083f22c9892dd2fc622dbf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "157c66875e07d80505677fcee2aa556e5ecb637e4d2bf0df59696e51fdf8bfc4"
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
