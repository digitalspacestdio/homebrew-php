require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Opcache < AbstractPhp83Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.14-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c27878bad7faaaadc4793166878cff1ad95fa09e991fbf59806e1de373dda520"
    sha256 cellar: :any_skip_relocation, ventura:       "d1e3b2adb0eddb1a77779037b6866ba3684303700c443716cc9f14513bb45ace"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "addfb44409fa5b6613a83d8080c35f99d07443b3ee96b80a272077b620ef9fae"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "7b7e4d7ad9470a410a78d9c7300ed505be51adb50a2d5e066d01a941f6d41bfd"
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
