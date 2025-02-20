require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Rdkafka < AbstractPhp82Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.27-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "255e73f70a68503cb3e5f794e92c7bfc9dc8f6eb73b8ff5ce3d90ae7ba18d5d6"
    sha256 cellar: :any_skip_relocation, ventura:       "42ff9242bafa669610174693758e1eedd5bb36162a6738f7a53be76bfa37cb0e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e83803d41381dda02b1b253ae156e8f9103ec2610e3bf30afaa0aa9fae153d44"
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
