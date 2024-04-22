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
    sha256 cellar: :any_skip_relocation, monterey:       "da35ce6006eb40c0d8875f5ad8f5ac4e3da3117ef229faa6eb580280e1f67a63"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a8ad4754f8d98353eb2f8cc85c2a895d07df85dafeb9be8b90f4920e4b75f832"
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
