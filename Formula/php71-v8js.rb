require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71V8js < AbstractPhp71Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-2.1.1.tgz"
  sha256 "0bed0cd24b3c2701d38773636f43dc2d8a8ff243ea220be3e427b8c8f5af3c8b"
  revision 1

  depends_on "v8"

  def install
    Dir.chdir "v8js-#{version}" unless build.head?

    v8 = Formula["v8"]
    cc_opt = "-I#{v8.opt_include}"
    ld_opt = "-L#{v8.opt_lib}"

    args = []
    args << "--with-cc-opt=#{cc_opt}/include"
    args << "--with-ld-opt=#{ld_opt}/libexec"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end
