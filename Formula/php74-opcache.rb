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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f0f2d8cf6c3c3a0dfb13bf1722b846e62e80847247bf011dc2b3b88f7f8b1220"
    sha256 cellar: :any_skip_relocation, ventura:       "af754db13218378dd03eae76fc62b14bcf1be06fdf20865ef00f47478629e8a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f092de38c5f2319c6dc549b8289857ffc382807dd7235cbf62bed523a28cc76f"
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
