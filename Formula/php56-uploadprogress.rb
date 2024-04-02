require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Uploadprogress < AbstractPhp56Extension
  init
  desc "An extension to track progress of a file upload."
  homepage "https://pecl.php.net/package/uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-1.0.3.1.tgz"
  sha256 "30588b4589543bcf6371532546b1a8cee9da1086c206aca9f96ea1bd486bbab2"
  head "https://svn.php.net/repository/pecl/uploadprogress/trunk/"
  revision PHP_REVISION

  depends_on "pcre2"

  def install
    Dir.chdir "uploadprogress-#{version}" unless build.head?

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                            phpconfig
    system "make"
    prefix.install "modules/uploadprogress.so"
    write_config_file if build.with? "config-file"
  end
end
