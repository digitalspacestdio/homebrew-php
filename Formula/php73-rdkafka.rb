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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a6afc122ae5c1ef9fda07c5209019ef8caef094fbdd06255e69f1be8566c583c"
    sha256 cellar: :any_skip_relocation, ventura:       "021b32de31ed4e9ef7bdaeb05b88d3c84a1449a7a3ad7fd51d5ff1e92def7c15"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7ea0ec35628536f47b0aba92367952986212f1b8e800b1cdc26d102a6bb46ccb"
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
