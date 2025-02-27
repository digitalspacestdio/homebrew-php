require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Rdkafka < AbstractPhp80Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "89a4e33149cde2f4ae9c881c9c26a667c5d878ca34d06bf93f193d1579779a32"
    sha256 cellar: :any_skip_relocation, ventura:       "cd12618868538128a0d57bcd7949dbad49898a9144ab59e2bbfeea4b89f4861f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0266e8f596ea69e4e0c52a8f50e951e2ab861469def240d1eb1abedfb0a8771f"
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
