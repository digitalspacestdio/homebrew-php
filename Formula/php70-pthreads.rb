require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pthreads < AbstractPhp70Extension
  init ["with-thread-safety"]
  desc "Threading API"
  homepage "https://pecl.php.net/package/pthreads"
  url "https://pecl.php.net/get/pthreads-3.1.6.tgz"
  sha256 "bb13da909a7a7ae1f9e499166103a2d24628993238ce03a8aae3eaa492c0b736"
  head "https://github.com/krakjoe/pthreads.git"



  def install
    Dir.chdir "pthreads-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/pthreads.so"
    write_config_file if build.with? "config-file"
  end
end
