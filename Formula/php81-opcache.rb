require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Opcache < AbstractPhp81Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6713287ad245c8876997f8bc3f78e36ad8d0661f3b1d689cd1da2fddb5a6dd7d"
    sha256 cellar: :any_skip_relocation, ventura:       "467764f9e8f6bb9323b2bb0afa3a0ce9bc683712c8b09ffebd2ebd7e2a6c8a58"
    sha256 cellar: :any_skip_relocation, monterey:      "6076cf574b8f9b2993df4563f8d0f85e6ce48cdc0d6b751d7ce2947316e93f50"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "19aa63a61486f96dce6ec417fdc78310738443af0b0911874fb464f5eddea01f"
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
