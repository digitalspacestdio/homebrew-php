require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Memprof < AbstractPhp56Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  homepage "https://tideways.com"
  url "https://codeload.github.com/arnaud-lb/php-memory-profiler/tar.gz/ad6d84bba4fade4be4580cd42f9662d3684861d7"
  sha256 "6976d1c0e82f9eb0ec859fcd6fe927b099c2186136efec34014331a3487844e7"
  head "https://github.com/arnaud-lb/php-memory-profiler.git", :branch => "php5"
  version "ad6d84b"
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
