require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Opcache < AbstractPhp73Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "24a58301ca3383443f6ecf860b1949fee72873b44c529d52e0db7a9d45f56cac"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1151003309ec8f4098b309ee1820a2cd0fa6697acfa4decff0948f0b445935ce"
    sha256 cellar: :any_skip_relocation, sonoma:        "d752cbe4082f0dcb2976befebf6dfbf63c4a1c22ebe520152b1842141f54adfe"
    sha256 cellar: :any_skip_relocation, monterey:      "5a3e4a7d248e9ff37737f60bb553785c14b41154b791276158834c72ba63c3dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cfaeaf4a108c39d75d6e61266dc813cf05c23177d5cc071f8f94ea62be768380"
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
