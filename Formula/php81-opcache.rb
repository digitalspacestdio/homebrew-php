require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Opcache < AbstractPhp81Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "121619f32fa877f3ee078d59b453ef46cd12a495110eccce2b105c2aa6fbde23"
    sha256 cellar: :any_skip_relocation, monterey:      "ea70728ebc87c1a38a6bc87d2e1db8553bbea651bbd4dae4f0e2f09f3073a64d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8b55159a273ede3b9b70e16c0eb0405213f9da76601ee1cb7fd9192f0f06a1ef"
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
