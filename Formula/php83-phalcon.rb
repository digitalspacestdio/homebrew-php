require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Phalcon < AbstractPhp83Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v5.6.2.tar.gz"
  sha256 "13685b9e99afee51ea771c4c59ec6d58713afa0fb862d8f073eeeb10117c7b12"
  head "https://github.com/phalcon/cphalcon.git"
  revision PHP_REVISION

  depends_on "pcre2"

  def install
    Dir.chdir "build/php7/64bits"

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
