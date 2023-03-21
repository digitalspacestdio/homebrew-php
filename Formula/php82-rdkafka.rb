require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Rdkafka < AbstractPhp82Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://github.com/arnaud-lb/php-rdkafka/archive/refs/tags/6.0.3.tar.gz"
  sha256 "058bac839a84f773c931776e7f6cbfdb76443849d3ea2b43ba43b80f64df7453"
  head "https://github.com/arnaud-lb/php-rdkafka.git"


  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/rdkafka.so"
    write_config_file if build.with? "config-file"
  end
end
