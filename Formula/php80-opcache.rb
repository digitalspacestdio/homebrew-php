require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Opcache < AbstractPhp80Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 19


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "17c1d0562ea642e754ba3406598c184030232fa2328ff9fb6ddb05c2c5800d91"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "21f14c7ac1682ffb1881819c09e94de650c6df771373ffda5cd5745c16636db1"
    sha256 cellar: :any_skip_relocation, sonoma:        "f4c662207e2466d4ee6ab82538c0b6229e6db19110168f8d9ce0b50e19f7e504"
    sha256 cellar: :any_skip_relocation, ventura:       "ac2089a3beab8374fa58c478c863416d1405d5d047571040ac9be27657f3bf40"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "38a0273ee63d96b96c12cabf400a328ae208a58624fa12ada439143b73f7c22b"
  end

  depends_on "pcre"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
