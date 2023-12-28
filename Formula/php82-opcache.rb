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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "223863b591ac80d076320b0034021067daa198dcdb1f2a76d7bbd560988c9dd2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7f226465fe163cb0f555776d081e865ff44a688d5c7e25a9a54289150bcd7e74"
    sha256 cellar: :any_skip_relocation, sonoma:        "4ee172bcee8c565b92e87335a4ae083074d98f3905d1a12be4603a778ebca84e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b51881534bbc45e712852d0eef5d6f4c9d5572d016d3a11ae3162e94510eeb5c"
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
