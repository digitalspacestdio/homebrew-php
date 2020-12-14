require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56V8js < AbstractPhp56Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "http://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-0.6.4.tgz"
  sha256 "88af2c98482374a36b24e317df4684b9eecc92d4883022fc8036a16f2641ca43"


  depends_on "v8"

  def install
    Dir.chdir "v8js-#{version}" unless build.head?

    # ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end
