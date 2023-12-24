require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Opcache < AbstractPhp71Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 20


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "05467b7c9a0cf760fb440d6a9df742de54da3c548b357b946f45e2a575d51af0"
    sha256 cellar: :any_skip_relocation, ventura:       "d7f3551ed368bb48c751605abdc7dca155c7d0f654c06472d32422bf0684993c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4f0cf95fbf5be16125fffb30afe401692e00428c69e02561b0a637031aef56da"
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
