require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Opcache < AbstractPhp74Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "49dea3bd3a6d26a05507935f271758fce5592436964dc5815add100cf992426b"
    sha256 cellar: :any_skip_relocation, monterey:       "09d44b23b3fc1e915cce3740514606ab961df11897bc7c818b89a0844fb6715c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4584b1411f9d954b84741570b69351bff694f77f1bbe284dd9e683f3c244bfbc"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "67bffc927b20034c98e9b2e27524eafd41f6dcf2634eb58d4340ead51a4bcab0"
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
