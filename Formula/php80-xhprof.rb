require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Xhprof < AbstractPhp80Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  homepage "https://tideways.com"
  url "https://codeload.github.com/tideways/php-xhprof-extension/tar.gz/97c780dc2cc905fded6d99bbe22eaf2c400a1aa0"
  sha256 "baf6dcbf6ae708c625bb2628ceda9c3c8f6ea4085d9d585122a233a9317dd5b6"
  head "https://github.com/tideways/php-xhprof-extension.git", :branch => "master"
  version "5.0.2"
  revision 1

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/tideways_xhprof.so" => "xhprof.so"
    write_config_file if build.with? "config-file"
  end
end
