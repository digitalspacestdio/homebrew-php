require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Opcache < AbstractPhp81Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "004b09aa0bc8a3a7d2ad9e1aab255dc381a5c83b43e1bda836b93430145ef949"
    sha256 cellar: :any_skip_relocation, ventura:       "5bff939575df6723ef454b556b3eeaed3212717c7713c193c0a0463dbe31ef86"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "19548af3f7b86c28621135755ae0a2701a8741167a60dd0d2f741827c3cbea7c"
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
