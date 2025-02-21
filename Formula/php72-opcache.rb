require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Opcache < AbstractPhp72Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "87ae55d8a2209a56a3557f094eec70c1009a63a032f4bd5c172c1099d436a27d"
    sha256 cellar: :any_skip_relocation, ventura:       "ed27fd4abaa63ff5752d8890ad0dcfd15b3763447fa5aa0854ebd4236eaaaa0c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b46e24b5838f45f7e5b542ea7853f732ad6cc5337574fc27976ce8891cbf1211"
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
