require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Xdebug < AbstractPhp83Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  #url "https://github.com/xdebug/xdebug/archive/master.tar.gz"
  #sha256 "b3afd650918ec5faaae0bf4b68cd9cd623d6477262792b2ac8f100aafa82d2f8"
  head "https://github.com/xdebug/xdebug.git"
  #version "3.3.0dev"
  revision 1

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
      xdebug.overload_var_dump=0
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
