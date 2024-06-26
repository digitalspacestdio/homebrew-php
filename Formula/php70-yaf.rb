require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Yaf < AbstractPhp70Extension
  init
  desc "PHP framework similar to zend framework built as PHP extension"
  homepage "https://pecl.php.net/package/yaf"
  url "https://github.com/laruence/yaf/archive/yaf-3.0.3.tar.gz"
  sha256 "6761e636d055ec6756759185e91cf9fd42ca3f59e36172d7773b8052a1fb4887"
  head "https://github.com/laruence/yaf.git"
  revision PHP_REVISION

  depends_on "pcre2"

  def install
    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/yaf.so"
    write_config_file if build.with? "config-file"
  end
end
