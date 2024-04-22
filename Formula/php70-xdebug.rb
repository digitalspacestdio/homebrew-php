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
    sha256 cellar: :any_skip_relocation, monterey:       "613d77ed663c7c56a0b82f97e09559e03602968d58cc3c7ae38fd6368b527b7f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4e74b0deee43490f9c065c349512b27bbfd012e7346d43b62ee7f2cdcc054e79"
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
