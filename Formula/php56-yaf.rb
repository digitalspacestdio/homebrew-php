require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Yaf < AbstractPhp56Extension
  init
  desc "Yaf is a PHP framework similar to zend framework, which is written in c and built as PHP extension"
  homepage "https://pecl.php.net/package/yaf"
  url "https://pecl.php.net/get/yaf-2.3.3.tgz"
  sha256 "fb59db901008b157d11c255f1a1492ccd02df2e2ab9869aa4f9fa9fc73272298"
  head "https://svn.php.net/repository/pecl/yaf/trunk/"
  revision PHP_REVISION

  depends_on "pcre2"

  def install
    Dir.chdir "yaf-#{version}" unless build.head?

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/yaf.so"
    write_config_file if build.with? "config-file"
  end
end
