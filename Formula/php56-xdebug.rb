require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xdebug < AbstractPhp56Extension
  init
  desc "Provides debugging and profiling capabilities for PHP"
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.5.tgz"
  sha256 "72108bf2bc514ee7198e10466a0fedcac3df9bbc5bd26ce2ec2dafab990bf1a4"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6ab552b88cab7cf01133985fcfa58c4496c1f9345d513629824007e172644285"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3b752e71d8bd614ecc88c21c43bfbf0e097649d67d4bdbac256340f132177297"
    sha256 cellar: :any_skip_relocation, sonoma:        "018e80291e20db988d40c74aeeae202bf9e77942a0542523fa9a31a062da89d1"
    sha256 cellar: :any_skip_relocation, monterey:      "0ed4a534667e0da8d8fd29d85f5451de60dffae8de39aa68499c9b53cc590ee7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1c04812d46064adab5a4168900b6ec11b775cd52a220a58cf01154a0238308d5"
  end
  depends_on :arch => :x86_64 if OS.linux?
  revision PHP_REVISION
  
  resource "linux_compiled" do
    url "https://f001.backblazeb2.com/file/php-homebrew/xdebug-linux.tgz"
    sha256 "48ebfdab01fd44f024157aa3ae25bef3bfdb5be085e474c2dcc583a06a4038d9"
  end

  def extension_type
    "zend_extension"
  end

  def install
    if OS.mac?
        Dir.chdir "xdebug-#{version}" unless build.head?

        safe_phpize
        system "./configure", "--prefix=#{prefix}",
                              phpconfig,
                              "--disable-debug",
                              "--disable-dependency-tracking",
                              "--enable-xdebug"
        system "make"
        prefix.install "modules/xdebug.so"
    elsif OS.linux?
        #TODO: add multiple architecture suppor (binaries already included in archive)
        resource("linux_compiled").stage { prefix.install "amd64/usr/lib/php/20131226/xdebug.so" }
    end
    write_config_file if build.with? "config-file"
  end
end
