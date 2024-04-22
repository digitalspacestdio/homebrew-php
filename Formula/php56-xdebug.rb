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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6625f8437c150d7da68b37735b36edf8e59ac11ec5b75c62534542124d34a54f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c0b49cad34152516686c778b548f9011942d300e824eb56036799fb0ba7e9937"
    sha256 cellar: :any_skip_relocation, sonoma:         "1b43ff2e0227bc30854424c3fd878299ff4391560230aee5a893e9aedcce71ae"
    sha256 cellar: :any_skip_relocation, monterey:       "9ff086cfe05acaac71bc6d8e36cd8ef0c36aa1b658d8f27e60c5b4480e1f4fe6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9388b8b8029a638c5a97543b76aa0ba7f99f22f5707dd7399c86e04654b64eec"
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
