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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f9a8f3e0affec889f63cc716f05241b089aa137ab24e7bee19c7e7abdf79e302"
    sha256 cellar: :any_skip_relocation, sonoma:        "10b47b8a5283e3b42a021d9dcd63e333721680ce82d0273d64fb51821c2481bc"
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
