require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Opcache < AbstractPhp73Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 20


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "81e3e6b4a6f384e256dad22ed5c1855943815694a70576de107434eaa3c68e81"
    sha256 cellar: :any_skip_relocation, ventura:       "ea194f67f8ea2abd8692faa518ce874b3d6695f1aa69603b3248b76dc9cbc8ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0f2fd80d0e1caf1d3f7e173f04c5cad681464a06061ec022715f6797d940a0a3"
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
