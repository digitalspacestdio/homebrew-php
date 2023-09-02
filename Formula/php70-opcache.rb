require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Opcache < AbstractPhp70Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 20

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6a7b57a897471c874a7da6c62979cd457ef2fcc427260e94a660076c42734e45"
    sha256 cellar: :any_skip_relocation, ventura:       "377bac8b204d9e0b45302e379070c4bdee3d0474f68df0b5b4bdeb0596a6caca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a132840b69ad5c9511e0c95a0bbdc78fb9f303aa44511c39f90b7473f1541b97"
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
