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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8d3d2ca03245b516cf499f6cfc82d2e351cffa05dd8d78ed57d555eb7fb13c51"
    sha256 cellar: :any_skip_relocation, monterey:       "6b8a67b62689dd809d7b7c00cfab8f66f1915540f8094e6cee0b0130987b18c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "938e0d1862f3df1fef06bb88aefe3e674e00ba255b07b1c7217f2831461cec02"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "4772b3a8d459e95432b507aff10bac1036eb97e6a0dab68d2c9ab3fcc8c552c4"
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
