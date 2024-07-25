require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Opcache < AbstractPhp80Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6a6f0af87b61052abe696adb5d143673391abc2d1eb659d6d74133d6dc64a781"
    sha256 cellar: :any_skip_relocation, monterey:       "d8509cce16f81a8f0f36364b88f709f488ab492db4c480338df1c57c17fdc18e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0196495fc4fa799d7004feed5ffec40ff65ef57457f955961100078a5bb01427"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "c0ec62a9e49aca48de5bb16ad2660ac80a20facf9c347d4ff6934a0900d2dff4"
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
