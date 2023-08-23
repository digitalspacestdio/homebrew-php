require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Memprof < AbstractPhp83Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  homepage "https://tideways.com"
  url "https://github.com/arnaud-lb/php-memory-profiler/archive/refs/tags/3.0.2.tar.gz"
  sha256 "c2532df14e1c60307a43ef5e180d29eee08bc81e98faee10b5909e19ecc777ca"
  head "https://github.com/arnaud-lb/php-memory-profiler.git", :branch => "master"
  version "3.0.2"

  depends_on "libjudy"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-judy-dir=#{Formula["libjudy"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/memprof.so" => "memprof.so"
    write_config_file if build.with? "config-file"
  end
end
