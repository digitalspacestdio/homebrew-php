require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Opcache < AbstractPhp80Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 19


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "596ae7fcdab759551ad29632c6d01dd711cbd2129de383c03abb1f2c1324308b"
    sha256 cellar: :any_skip_relocation, ventura:       "ac2089a3beab8374fa58c478c863416d1405d5d047571040ac9be27657f3bf40"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4a2874d5ce78d31d555f79826f33f883616e14400e082dd63270eb604d336f2e"
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
