require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Opcache < AbstractPhp71Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ad2eaf60a53a5ed8c960996437258e3f8345ac7df4ef73f645a7ce6ef616327a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7cfb57e4b3946e17b2ae2bd139e2dfe1bb8e8cf3fd845ad4a4577a26f2e2d311"
    sha256 cellar: :any_skip_relocation, monterey:       "9fad7c2235c9aafa65be9fb644200f3b4505f59192a97651c25a3c0612fe46cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4f0f8f4ffc8c4e11d19454a4824bc691b3b93368750a63c6dd66c20776551731"
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
