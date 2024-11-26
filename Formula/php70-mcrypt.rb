require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "https://php.net/manual/en/book.mcrypt.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "digitalspacestdio/common/mcrypt@2.6"
  depends_on "libtool" => :build

  def install
    Dir.chdir "ext/mcrypt"

    args = []
    args << "--prefix=#{prefix}"
    args << "--disable-dependency-tracking"
    args << "--with-mcrypt=#{Formula["digitalspacestdio/common/mcrypt@2.6"].opt_prefix}"
    args << phpconfig

    safe_phpize
    system "./configure", *args
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end
