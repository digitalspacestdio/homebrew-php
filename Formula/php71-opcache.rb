require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Opcache < AbstractPhp71Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 20


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3c61cc8d7427d18d08c396be767d2a9adc39e849aef2e82622134c950b7c9319"
    sha256 cellar: :any_skip_relocation, sonoma:        "30b75a3be58831293ec90e3f0560823b5e84943be86d4a14f752b15dd1f3a125"
    sha256 cellar: :any_skip_relocation, ventura:       "d7f3551ed368bb48c751605abdc7dca155c7d0f654c06472d32422bf0684993c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "827e7fcf484d7f7a8ba97cc74e0d49d85d7faa7e3ca84c94a14a720f40ac8ecf"
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
