require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Xhprof < AbstractPhp82Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  homepage "https://github.com/longxinH/xhprof"
  head "https://github.com/longxinH/xhprof.git", :branch => "v2.3.10"
  url "https://github.com/longxinH/xhprof/archive/da774867b337de4a1caeb5dfdd6a3f6793f73391.tar.gz"
  sha256 "db19e28bbf594100b992390b6705b3f7794290d9cb9db721346082e54653926e"
  version "v2.3.10"
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
