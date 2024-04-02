require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Memprof < AbstractPhp81Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  homepage "https://tideways.com"
  url "https://codeload.github.com/arnaud-lb/php-memory-profiler/tar.gz/9a47f88ae139b902030b4156125d2a645a812f3c"
  sha256 "2f9f3e2c6f3adefd370082d548c97b66f51191424c9a7a1697ed82273ff9a325"
  head "https://github.com/arnaud-lb/php-memory-profiler.git", :branch => "master"
  version "9a47f88"
  revision PHP_REVISION
  depends_on "libjudy"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-judy-dir=#{Formula["libjudy"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/memprof.so" => "memprof.so"
    write_config_file if build.with? "config-file"
  end
end
