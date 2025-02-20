require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Rdkafka < AbstractPhp71Extension
  init
  desc "PHP extension for Apache Kafka (php-rdkafka)"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a602f7aa83cfdc56ec98f0cad1414f4e2f426304e83fe6ffec38b7e25ce52ce9"
    sha256 cellar: :any_skip_relocation, ventura:       "7b9ee4e18e1d837d515553a33cf793b598fa9e841a259b4710229a5f402f9e02"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "639c6a001e11beb910290e804596e064fba98d6bec3d59e1c113de3361033725"
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
