require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Rdkafka < AbstractPhp73Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, ventura:      "33449f0e282db083ba23d1505cebfd6ec52bcc9b8d9fd0d2ad898e075502eee9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ff2e976a7654c23a7c42926d4004a832b4f04790a80879612a973e0b1a0b31eb"
  end

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
