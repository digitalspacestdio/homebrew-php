require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Opcache < AbstractPhp72Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dcd56034016c29f4c94c1154b14a3b3e3923e2016c4f3efcfb99b89bf94920b2"
    sha256 cellar: :any_skip_relocation, monterey:       "f387e35b3929b2291a4353f45551b743e52f86662bc1404216389c0bd5ae1b69"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "210df8f172d7ae3a6bcb80cc8cc3460f539c1e57be2e2b378d72f1228ac2b846"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "cd863f4a9c07653e67cd5e55b3543e4574b02efd5edfcf70a3c35d8b32220a35"
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
