require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Opcache < AbstractPhp83Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.3.8-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "72da01ba576011a41f07bad117a5e19515ba5be50134edf6e63e5ea8094c6fac"
    sha256 cellar: :any_skip_relocation, monterey:       "ce8cb7fb781dec33765e1fdd19259e9b654940177ae0a443412bb5e658544f80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3e096a7dd826ed2bfca1f01604710d28d0f887916be8ead1ede5092c8e597067"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "f42b696e82d09d64ce1e5c70c1fb6d5a652592d323b057585fc47a7772641492"
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
