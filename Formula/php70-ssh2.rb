require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ssh2 < AbstractPhp70Extension
  init
  desc "Provides bindings to the functions of libssh2"
  homepage "https://pecl.php.net/package/ssh2"
  url "https://pecl.php.net/get/ssh2-1.1.2.tgz"
  sha256 "87618d6a0981afe8c24b36d6b38c21a0aa0237b62e60347d0170bd86b51f79fb"
  head "https://github.com/php/pecl-networking-ssh2.git"
  revision PHP_REVISION

  depends_on "libssh2"

  def install
    Dir.chdir "ssh2-#{version}" unless build.head?
    
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-ssh2=#{Formula["libssh2"].opt_prefix}"
    system "make"
    prefix.install "modules/ssh2.so"
    write_config_file if build.with? "config-file"
  end
end
