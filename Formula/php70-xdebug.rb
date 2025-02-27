require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdebug < AbstractPhp70Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/2.7.2.tar.gz"
  sha256 "b2aeb55335c5649034fe936abb90f61df175c4f0a0f0b97a219b3559541edfbd"
  version "2.7.2"
  revision PHP_REVISION+1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2ff5e63ea4183dad6ccda834e41bbadc99c360e00c9d2bc3b229a42ae5d52855"
    sha256 cellar: :any_skip_relocation, ventura:       "bedb0d136040ffdf7d2c73655368f1c06b08356420b05b2ee91a4cf003f9678f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9eb4fe2899004d4d3e825e8c08fa05ee93c16fff4e3b14d7c0f44d26eb4cae15"
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
