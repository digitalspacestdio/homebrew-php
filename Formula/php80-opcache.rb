require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Opcache < AbstractPhp80Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "45eeaaac7e6c6fb9e6bc797dee13bc708f91c8f0ba77b6d6fe0f1a4e9207111c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "849b041a288389e28746953e5b4b17f3ac796c9d3ca9408fa0726b24c2bd5709"
    sha256 cellar: :any_skip_relocation, sonoma:        "e8c88a4b04b1307e8595575545a85ad523d38ce06db85dad1608689980515e9f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "02a2317815186fc30123558874d5b8bfe8859ba841dca672a664db25fbbfea39"
  end

  depends_on "pcre2"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
