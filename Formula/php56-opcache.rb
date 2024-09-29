require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Opcache < AbstractPhp56Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/5.6.40-104"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "390609f97cddc50b52cee5df7c71436171341044c8cffd8f5f9de80792cd8a97"
    sha256 cellar: :any_skip_relocation, ventura:       "504909962a967ac02e64fcd1dbd9de6e4e2e6b6d463e8ec560113c2a5ec94f01"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "b5c97c4873bfbf22bfa5b3d7afd36e47dc753f3ddd95945ce0942ed65f96ddd0"
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
