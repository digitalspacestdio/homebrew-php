require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdebug < AbstractPhp70Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/2.7.2.tar.gz"
  sha256 "b2aeb55335c5649034fe936abb90f61df175c4f0a0f0b97a219b3559541edfbd"
  version "2.7.2"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ba2bd46b1c0b50f0f5e2f85dfc94cb6269de84421e946482f3d23418bb3344f9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6842a3792d766023229ceae26235ec3c240dab6da936f5f08f8be99f051e4528"
    sha256 cellar: :any_skip_relocation, monterey:       "e807b6837cb752770a084179cc7b91a77d56bec7bd9c0f37d9225eef50826bba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ec01afb98b1af14bb70671d1b02091bdcfd29545792cde55b309f9274b81d1cb"
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
