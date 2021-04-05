require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Http < AbstractPhp72Extension
  init
  desc "HTTP extension that provides a convenient set of functionality"
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_3_1_0.tar.gz"
  sha256 "6b931205c1af59bba227715dd846b1495b441b76dabd661054791ef21b719214"
  head "https://github.com/m6w6/ext-http.git"
  revision 2


  depends_on "php72-raphf"
  depends_on "php72-propro"
  depends_on "libevent" => :optional
  depends_on "icu4c@67.1" => :optional

  def config_filename
    "zzz_ext-" + extension + ".ini"
  end

  def install
    # ENV.universal_binary if build.universal?

    safe_phpize

    # link in the raphf extension header
    mkdir_p "ext/raphf"
    cp "#{Formula["php72-raphf"].opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"
    cp "#{Formula["php72-raphf"].opt_prefix}/include/php_raphf_api.h", "ext/raphf/php_raphf_api.h"

    # link in the propro extension header
    mkdir_p "ext/propro"
    cp "#{Formula["php72-propro"].opt_prefix}/include/php_propro.h", "ext/propro/php_propro.h"
    cp "#{Formula["php72-propro"].opt_prefix}/include/php_propro_api.h", "ext/propro/php_propro_api.h"

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-http-libcurl-dir"
    args << "--with-http-zlib-dir"
    args << "--with-http-libevent-dir=#{Formula["libevent"].opt_prefix}" if build.with? "libevent"
    args << "--with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}" if build.with? "icu4c"

    system "./configure", *args
    system "make"
    prefix.install "modules/http.so"
    write_config_file if build.with? "config-file"

    # remove old configuration file
    rm_f config_scandir_path / "ext-http.ini"
  end
end
