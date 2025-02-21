require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Rdkafka < AbstractPhp81Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ebe118e1f25bea68157460f42e8f114bbe4db417de9a61f0050d0276f9faecee"
    sha256 cellar: :any_skip_relocation, ventura:       "b9a30835888906cca371fe0a2b93d2a1f552c8d57e2a90361bdbf8d36da6dc1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e28b0de6c9f5ba25b86040dd00682208d979b5d3403e11b9a2549d5b77477ef3"
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
