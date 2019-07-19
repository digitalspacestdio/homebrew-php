require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Xdebug < AbstractPhp74Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
#   url "https://xdebug.org/files/xdebug-2.8.0alpha1.tgz"
#   sha256 "28b773c233cb9af242bf8e518246bb171ed9cccfbef249a487c5c63d4c8a6165"
  url "https://codeload.github.com/xdebug/xdebug/tar.gz/a9c5037e2a4ee258a19aea6dfbe049b9901a640d"
  sha256 "346bea3f6027b67410286c9c68ebc04d34afdf68302c8a3a07916867cf21e144"
  version "a9c5037"
  head "https://github.com/xdebug/xdebug.git"

  def extension_type
    "zend_extension"
  end

  def install
    #Dir.chdir "xdebug-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-xdebug"
    system "make clean"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end
end
