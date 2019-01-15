require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Memprof < AbstractPhp70Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  homepage "https://tideways.com"
  url "https://codeload.github.com/arnaud-lb/php-memory-profiler/tar.gz/bc76256dd39530d8534a26e6a8e5e2c5d6535c4e"
  sha256 "fed07166ab1ce81ecb16ddd586a6456c6b574b72e965d1a9d1c0debdef374db1"
  head "https://github.com/arnaud-lb/php-memory-profiler.git", :branch => "master"
  version "bc76256"

  depends_on "libjudy"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/memprof.so" => "memprof.so"
    write_config_file if build.with? "config-file"
  end
end
