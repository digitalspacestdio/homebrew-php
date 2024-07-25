require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Opcache < AbstractPhp74Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7ffebb778f837f08d8823d8529f912a7298f7bfba5b2589d8022fe95889fcc6e"
    sha256 cellar: :any_skip_relocation, monterey:       "681d96dfd8fd16900ff4cbf7a3bc6e84605ba5862244bdb66db7169e7713cc75"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "061f820376832261625e54cf7c8d6d8f29b8e84996db93c51f1952098316e83d"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "9b054f95b3a9d7359aeb83c71e2699e16df18066598bcdf1c79f6cd1aab3d6e2"
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
