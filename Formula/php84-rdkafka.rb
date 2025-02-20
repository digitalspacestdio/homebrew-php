require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Rdkafka < AbstractPhp84Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.4-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b73b1e7185c783209539014dee0a0ac8108f33e7c1754a8e4ad8c67273e13230"
    sha256 cellar: :any_skip_relocation, ventura:       "e982e6ca812c9e223199573ed358918d6829c1bea96fea305ec339682d4059d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8a0011ab454d4b008a4f28a1f7ddb865b112a8b8efd61efa38cd7456ca511dd8"
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
