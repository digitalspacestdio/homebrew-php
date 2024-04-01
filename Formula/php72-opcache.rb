require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Opcache < AbstractPhp72Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cde837c03addd9ef3eeda0d5809912c2ee175b81977390c67094fb15043ca777"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b458ba39e79d8327d5d85656941f3050d9d4123d0da3097c261c8579773e9c91"
    sha256 cellar: :any_skip_relocation, sonoma:        "aec8f1bb0b202349decdf0645b3c809151eb5167de8e2bcb472db1497ff12208"
    sha256 cellar: :any_skip_relocation, monterey:      "2e99cb328e04b7d65aaef3ba1a480603fc0725442a3890327c45bacc0240f48b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f301f9177f6ab63e6263415d55b4d5da6d1bf2ee74bfc09b6d2c51a28e36f6f3"
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
