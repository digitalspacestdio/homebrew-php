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
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "24a58301ca3383443f6ecf860b1949fee72873b44c529d52e0db7a9d45f56cac"
    sha256 cellar: :any_skip_relocation, sonoma:       "52b0cc63e49f7650631e1a8d2f7649f9edae2f2edc684366909a7a97394227b9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4b91013326d8c9e0775878233b3052ed8f0d434e25b0dfe2baf9411f2e32c08e"
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
