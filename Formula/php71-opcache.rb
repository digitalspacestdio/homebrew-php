require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Opcache < AbstractPhp71Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5e380c5e9f0defd1c0d38246976c8b1234c3a336b5c1371dd15c6e1d6583fe0b"
    sha256 cellar: :any_skip_relocation, monterey:       "955177e741b372cfa00a11845c8de7589ba8d80f4f2d4c84aa9a04590911d1dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2f40d7043fb7a7e964d91fcd85ac534e209c4192ce35f83bb0aaaf94bcbdf73c"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "b55f0ddec0913de529526908c0a4cfbcfcc0abd772e6a16291298caa27de2313"
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
