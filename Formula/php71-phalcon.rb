require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Phalcon < AbstractPhp71Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.3.0.tar.gz"
  sha256 "559211b861a71ae6032216b2dc41d085560354072c95d1000b13fd37b0e0e008"
  head "https://github.com/phalcon/cphalcon.git"
  revision PHP_REVISION

  depends_on "pcre2"

  def install
    Dir.chdir "build/php7/64bits"

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
