require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Xhprof < AbstractPhp80Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  homepage "https://github.com/longxinH/xhprof"
  url "https://codeload.github.com/longxinH/xhprof/tar.gz/3d256898fb4f8443fec43c7f4bd7ae439e8aeff2"
  sha256 "c73b98a4f54dbee6570692a1ec6faef41653bb32bd02397a0229f458b99754c5"
  head "https://github.com/longxinH/xhprof.git", :branch => "master"
  version "2.2.3"
  revision 1

  def install
    Dir.chdir "extension"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/xhprof.so" => "xhprof.so"
    write_config_file if build.with? "config-file"
  end
end
