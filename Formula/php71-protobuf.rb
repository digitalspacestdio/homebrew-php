require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Protobuf < AbstractPhp71Extension
  init
  desc "Google's language-neutral, platform-neutral, extensible mechanism for serializing structured data."
  homepage "https://pecl.php.net/package/protobuf"
  url "https://pecl.php.net/get/protobuf-3.4.0.tgz"
  sha256 "510d8ea544e3d5fc44fa5d13f6db5dd7af3e292aee66f90409f95f4450414a71"
  revision PHP_REVISION

  depends_on "protobuf"

  def install
    Dir.chdir "protobuf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file if build.with? "config-file"
  end
end
