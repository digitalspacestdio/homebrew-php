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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6950df0d3516f20eede740604053cbbac599051fcfc369fc1414cf607a25519d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a4efe5a23af2d0ae0652cfe18280448c3d7519790d5d9ab50bcf926a8574e1bd"
    sha256 cellar: :any_skip_relocation, sonoma:        "9592b7a91ad2a7c251769a1254066301f55033a552283df5d35c169918d4b11a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "83178b254f8bce5c0e92d92d10a283057088619a91cfc27be47d10a143b651d1"
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
