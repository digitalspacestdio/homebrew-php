require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Xhprof < AbstractPhp80Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  homepage "https://github.com/longxinH/xhprof"
  url "https://codeload.github.com/longxinH/xhprof/tar.gz/2b14d1ab76195f4d460a240a55aed3724df93c51"
  sha256 "522521f0d870b8b19462cd9cfc4f71a0c0bb2712310b723d9fe7863035206f77"
  head "https://github.com/longxinH/xhprof.git", :branch => "master"
  version "2.2.2-beta"
  revision 1

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/xhprof.so" => "xhprof.so"
    write_config_file if build.with? "config-file"
  end
end
