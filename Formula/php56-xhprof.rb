require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xhprof < AbstractPhp56Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  head "https://github.com/tideways/php-xhprof-extension.git", branch: "4.x"
  url "https://github.com/tideways/php-xhprof-extension/archive/9b1c124a8cf75ed4ecf126c213b50c206df6a9db.tar.gz"
  sha256 "9f84f5e8dca4b38921343a6e389da101e7d1e83ee0077220fd3f747cb67945a4"
  version "4.1.7"
  revision 1
  depends_on "pcre"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/tideways.so" => "xhprof.so"
    write_config_file if build.with? "config-file"
  end
end
