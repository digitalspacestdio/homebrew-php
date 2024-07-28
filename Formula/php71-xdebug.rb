require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xdebug < AbstractPhp71Extension
  init PHP_VERSION, false
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/2.7.2.tar.gz"
  sha256 "b2aeb55335c5649034fe936abb90f61df175c4f0a0f0b97a219b3559541edfbd"
  version "2.7.2"
  revision PHP_REVISION+1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "45001804006865771265b753b9316528a3c6f08480ab5d2680bf19bc545c7e46"
    sha256 cellar: :any_skip_relocation, monterey:       "e5aefe4adaf9ab5a77ac1b39965a1a52363d88f617db03bcf4c874d164e469cd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8c6478de4617378e8a2dc48f66e42a63b966f9cd9315da19bcd22e720c7fa2bd"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "2701b7e8151ac00aec3b981d683f56b2ddd398b94de1e5bd9c9ff9e237abc193"
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
