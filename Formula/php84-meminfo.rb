require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Meminfo < AbstractPhp84Extension
  init
  desc "PHP extension to get insight about memory usage"
  homepage "https://github.com/BitOne/php-meminfo"
  url "https://github.com/BitOne/php-meminfo.git",
    :tag => "v1.1.1",
    :revision PHP_REVISION
  head "https://github.com/BitOne/php-meminfo.git"


  def install
    Dir.chdir "extension/php7" unless build.head?

    # ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/meminfo.so]
    write_config_file if build.with? "config-file"
  end
end
