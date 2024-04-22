require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xdebug < AbstractPhp71Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/2.7.2.tar.gz"
  sha256 "b2aeb55335c5649034fe936abb90f61df175c4f0a0f0b97a219b3559541edfbd"
  version "2.7.2"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "bb39d339904c54a3cbcababd2569e8540e9df0606835ba7bc3adc6f415f3da86"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "add320620f53e841ff90743a7f423774793bb581405b3fab898ca317793f6824"
    sha256 cellar: :any_skip_relocation, monterey:       "cc0e93e4190332423b9029cc48a51f4daaaa6fd0b223f71020e54b90af5d1e22"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3f518b8b44d075dc9027d723ebfb20a9092292417adbda33bb2d21d69f36a38b"
  end


  def extension_type
    "zend_extension"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
  end

  def post_install
    write_config_file
  end
end
