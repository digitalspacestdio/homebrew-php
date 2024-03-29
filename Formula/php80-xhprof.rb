require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Xhprof < AbstractPhp80Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  homepage "https://github.com/longxinH/xhprof"
  url "https://codeload.github.com/longxinH/xhprof/tar.gz/ca4cde86ae6a7f40a1ddec044e4999d8a119e944"
  sha256 "d9620cf3f1030b7da0390f4fd29161db18836541a866e6acde31c9e11a0ea04b"
  head "https://github.com/longxinH/xhprof.git", :branch => "master"
  version "2.3.5"
  revision PHP_REVISION

  def install
    Dir.chdir "extension"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/xhprof.so" => "xhprof.so"
    write_config_file if build.with? "config-file"
  end
end
