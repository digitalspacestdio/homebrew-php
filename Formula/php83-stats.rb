require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Stats < AbstractPhp83Extension
  init
  desc "Extension with routines for statistical computation."
  homepage "https://pecl.php.net/package/stats"
  url "https://pecl.php.net/get/stats-2.0.3.tgz"
  sha256 "7f2bc60136594cea27d9f997a6622270408ca90c4428f6f2e20938c88fab1b57"
  head "https://github.com/php/pecl-math-stats.git"
  revision PHP_REVISION

  def install
    Dir.chdir "stats-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/stats.so"
    write_config_file if build.with? "config-file"
  end
end
