require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Rdkafka < AbstractPhp56Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-4.1.2.tgz"
  sha256 "8ae04c240ce810bc08c07ea09f90daf9df72f0dde220df460985945a3ceec7fc"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  revision PHP_REVISION

  depends_on "pcre2"
  depends_on "librdkafka"

  def install
    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    Dir.chdir "rdkafka-#{version}" unless build.head?
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/rdkafka.so"
    write_config_file if build.with? "config-file"
  end
end
