require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdebug < AbstractPhp70Extension
  init PHP_VERSION, false
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/2.7.2.tar.gz"
  sha256 "b2aeb55335c5649034fe936abb90f61df175c4f0a0f0b97a219b3559541edfbd"
  version "2.7.2"
  revision PHP_REVISION+1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ad7da4bd4875b0ce1308755c523022eebde7edc963096706a525acad5feffec3"
    sha256 cellar: :any_skip_relocation, monterey:       "48fd7637bbe48fccac1811dfd711777c801a56d13d8cfef2d82e0cf6f265a5c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8821884b138a7f91468473b5c512ae7f675f69c7ed9cce3707851733c318ab59"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "b3ea4188e8f3de8e471eb5b7837c661191369c5964b31e852531105acc4a2ecf"
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
