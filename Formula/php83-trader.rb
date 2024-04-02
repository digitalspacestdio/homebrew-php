require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Trader < AbstractPhp83Extension
  init
  desc "Technical Analysis for traders"
  homepage "https://pecl.php.net/package/trader"
  url "https://pecl.php.net/get/trader-0.5.1.tgz"
  sha256 "3e99cf1066bfb43f026451f343ee81004f231540e7cef5e2574d410b9910de32"
  head "https://github.com/php/pecl-math-trader.git"
  revision PHP_REVISION

  depends_on "ta-lib"
  depends_on "libtool" => :build

  def install
    Dir.chdir "trader-#{version}"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/trader.so"
    write_config_file if build.with? "config-file"
  end
end
