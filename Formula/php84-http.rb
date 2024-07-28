require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Http < AbstractPhp84Extension
  init
  desc "HTTP extension that provides a convenient set of functionality"
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/v4.2.4.tar.gz"
  sha256 "a2d588a71aa2968ec5fa4a20dbccdfb6f98b0ab9e2d0e61cc862479fee3d409b"
  head "https://github.com/m6w6/ext-http.git"
  revision PHP_REVISION


  depends_on "digitalspacestdio/php/php81-raphf"
  depends_on "digitalspacestdio/php/php81-propro"
  depends_on "libevent" => :optional
  depends_on "digitalspacestdio/common/icu4c@72.1" => :optional

  def config_filename
    "zzz_ext-" + extension + ".ini"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/http.so"
    write_config_file if build.with? "config-file"
  end
end
