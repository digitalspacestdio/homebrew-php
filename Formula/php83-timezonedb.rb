require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Timezonedb < AbstractPhp83Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2024.1.tgz"
  sha256 "6031d5c4fe7daba91e5b6cf46a58b0df89d8e1a963d28f38b3df091843c39c46"
  head "https://github.com/php/pecl-datetime-timezonedb.git"
  revision PHP_REVISION


  def install
    Dir.chdir "timezonedb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/timezonedb.so"
    write_config_file if build.with? "config-file"
  end
end
