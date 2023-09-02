require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Opcache < AbstractPhp82Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "eb3358fce939ada637aeaaec2b50b875ba7f1983168fe2247a730ab1e8ff5de5"
    sha256 cellar: :any_skip_relocation, ventura:       "0f6965c233fa5042db884b872eb4290a95ddc6ad468c2d2a04d01cfe6b042f12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4bd1af160910089e7937cf36bfb944a7c2180eebb6fa29eca3b69a1b834dfe52"
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
