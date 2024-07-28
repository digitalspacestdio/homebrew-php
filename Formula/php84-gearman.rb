require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Gearman < AbstractPhp84Extension
  init
  desc "PHP wrapper to libgearman"
  homepage "https://github.com/wcgallego/pecl-gearman"
  url "https://github.com/wcgallego/pecl-gearman/archive/gearman-2.0.6.tar.gz"
  sha256 "3f5fe79905fce8ae4eeaf125aa4b5cdd55d3d134112f035ddbb30722897a912e"
  head "https://github.com/wcgallego/pecl-gearman.git"
  revision PHP_REVISION


  depends_on "gearman"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-gearman=#{Formula["gearman"].opt_prefix}"

    system "make"
    prefix.install "modules/gearman.so"
    write_config_file if build.with? "config-file"
  end
end
