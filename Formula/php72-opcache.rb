require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Opcache < AbstractPhp72Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 20


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b2da3732bc8088284519f3c69857fcf607c4ae102883bbfdc8813db861ac17c6"
    sha256 cellar: :any_skip_relocation, ventura:       "a17cb25c2a8202d6f0788e42417310014540f2a87ec1832b441eb8c1d4def87d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9d97b6d3e64285aaeee85ef1e0d46a7874dadbbc508a6ea307074ae14ee1e54b"
  end

  depends_on "pcre"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
