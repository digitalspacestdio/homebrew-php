require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xhprof < AbstractPhp71Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  homepage "https://tideways.com"
  url "https://codeload.github.com/tideways/php-xhprof-extension/tar.gz/ab391914cd59b95ea1a6904eacad6960a696a50b"
  sha256 "1cfc8655b3561bd1b6ed778584f7e8ba36b7dac7cce1f3abb366093591dc526a"
  head "https://github.com/tideways/php-xhprof-extension.git", :branch => "master"
  version "5.0.4"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/tideways_xhprof.so" => "xhprof.so"
    write_config_file if build.with? "config-file"
  end
end
