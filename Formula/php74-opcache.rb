require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Opcache < AbstractPhp74Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 19


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "830aefba843c076b511629bc30bf5eaf23f9a69d87f5f592cce10fa64dc567b4"
    sha256 cellar: :any_skip_relocation, sonoma:        "d7019221ce2b09c65bb749348fa22bdad011cc5dcb298393997077647d036c77"
    sha256 cellar: :any_skip_relocation, ventura:       "af754db13218378dd03eae76fc62b14bcf1be06fdf20865ef00f47478629e8a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8771e77cacc68e883d92a2d34ab7d4f9ac14fcb0e372a70d26b97629e994b05"
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
