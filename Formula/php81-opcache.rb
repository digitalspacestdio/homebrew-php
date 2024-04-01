require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Opcache < AbstractPhp81Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "f9afeefddd46bde9d40cba96b88912ffafef9d2f10d8ab05a70714c37b57ba24"
    sha256 cellar: :any_skip_relocation, sonoma:       "7b923100a4bea3ef835f9462c3cb05f297da2a4cba26f8cf6456e68d7b37b575"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6c6bc77ba282e714bba2b009d68f5f38bac4029ec1a132aee26be8698a501947"
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
