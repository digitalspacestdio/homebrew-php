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
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "3e88ea32e92cfb4a10e1d384f318be92f6a3b8fd06170eb7457573cd64b3a089"
    sha256 cellar: :any_skip_relocation, sonoma:       "3078f78f591464327ad799713226ccb69796866418f93521974b941699ac0178"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "09e751bee9666f1867d770fb77864bdb3dcac45551557f718fa88b63ecdc0961"
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
