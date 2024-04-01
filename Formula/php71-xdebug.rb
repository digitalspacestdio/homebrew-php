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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f221b6ea53a3545a3fc2b7ff9de9e61b9d5287b85a4563189e9b2ea249d6dd4b"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "52807e4fae0b3b13887b73bf8306669dccb965bf7c1e0e7f50382c0dec1f575b"
    sha256 cellar: :any_skip_relocation, sonoma:        "30e0ac54de1744a95f538e5719c43266bddbb3726e8d20ebed9fc378cf0f2acf"
    sha256 cellar: :any_skip_relocation, monterey:      "8b001340e79229edf1beaaa46725c90d437aeca726d7cc4a84de318cc6fb8ff8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58f1613ecd1ed56eb215de9d44d981df35d037b66f4d6d09d8af92a587ab9897"
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
