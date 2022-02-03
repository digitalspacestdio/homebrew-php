require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Mcrypt < AbstractPhp73Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url "https://pecl.php.net/get/mcrypt-1.0.1.tgz"
  sha256 "a3b0e5493b5cd209ab780ee54733667293d369e6b7052b4a7dab9dd0def46ac6"
  head "https://github.com/chuan-yun/Molten.git"
  revision 4


  depends_on "mcrypt"
  depends_on "libtool" => :build

  def install
    Dir.chdir "mcrypt-1.0.1"

    args = []
    args << "--prefix=#{prefix}"
    args << "--disable-dependency-tracking"
    args << "--with-mcrypt=#{Formula["mcrypt"].opt_prefix}"
    args << phpconfig

    safe_phpize
    system "./configure", *args
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end
