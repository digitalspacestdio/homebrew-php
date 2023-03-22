require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xdebug < AbstractPhp56Extension
  init
  desc "Provides debugging and profiling capabilities for PHP"
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.5.tgz"
  sha256 "72108bf2bc514ee7198e10466a0fedcac3df9bbc5bd26ce2ec2dafab990bf1a4"
  head "https://github.com/xdebug/xdebug.git"
  depends_on :arch => :x86_64 if OS.linux?

  resource "linux_compiled" do
    url "https://f001.backblazeb2.com/file/php-homebrew/xdebug-linux.tgz"
    sha256 "48ebfdab01fd44f024157aa3ae25bef3bfdb5be085e474c2dcc583a06a4038d9"
  end

  def extension_type
    "zend_extension"
  end

  def install
    if OS.mac?
        Dir.chdir "xdebug-#{version}" unless build.head?

        safe_phpize
        system "./configure", "--prefix=#{prefix}",
                              phpconfig,
                              "--disable-debug",
                              "--disable-dependency-tracking",
                              "--enable-xdebug"
        system "make"
        prefix.install "modules/xdebug.so"
    elsif OS.linux?
        #TODO: add multiple architecture suppor (binaries already included in archive)
        resource("linux_compiled").stage { prefix.install "amd64/usr/lib/php/20131226/xdebug.so" }
    end
    write_config_file if build.with? "config-file"
  end
end
