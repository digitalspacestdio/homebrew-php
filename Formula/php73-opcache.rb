require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Opcache < AbstractPhp73Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 20


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c578ff524b87201105ae03899fa4e7ecec34f6766afa2ca681d2cb3918102e3f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4429d009389ab7cb982be4f2e01fd3af374bc78e4593da2fc8134deeb774e6d2"
    sha256 cellar: :any_skip_relocation, sonoma:        "5c0f42b0a4a017cacb0a8e850370515c8e8f01631fc9b4e820a721132d3e2e79"
    sha256 cellar: :any_skip_relocation, ventura:       "ea194f67f8ea2abd8692faa518ce874b3d6695f1aa69603b3248b76dc9cbc8ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef8dda6eb8a1c824eb151deb867dc46d102f4ccafea33e20ba712ccfb32493f1"
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
