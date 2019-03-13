require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xhprof < AbstractPhp71Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  homepage "https://tideways.com"
  url "https://codeload.github.com/tideways/php-xhprof-extension/tar.gz/afc61bd1e3336ef207247c5e92ae6b5dab0a6e1c"
  sha256 "64f1c8e97e3480ccf329716bfc80ad4597d3f1a89f6f10c04c87c0a1443573a5"
  head "https://github.com/tideways/php-xhprof-extension.git", :branch => "master"
  version "afc61bd"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/tideways_xhprof.so" => "xhprof.so"
    write_config_file if build.with? "config-file"
  end
end
