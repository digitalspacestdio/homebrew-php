require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xhprof < AbstractPhp56Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  head "https://github.com/tideways/php-xhprof-extension.git", branch: "4.x"
  url "https://github.com/tideways/php-xhprof-extension/archive/refs/tags/v4.1.7.tar.gz"
  sha256 "3e32ceacc9eec481e27b5df6d06de1e634294e2af9a64fe069bc686dba54fcb8"
  version "4.1.7"
  revision 1
  depends_on "pcre"

  def install
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/tideways.so" => "tideways.so"
    write_config_file if build.with? "config-file"
  end
end
