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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a30046d80f0c930f0733760ceb7cf26b184bbbc45526ca431f6b0e19567df22f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a4cb51ad776afb552886260f38683945bda35c729d4ee2a7e2b41a5bddb9c553"
    sha256 cellar: :any_skip_relocation, sonoma:        "e042f9a3dad624f7e977424f7180cba7492bc4bd3cf885e99a0c72cf16d16b92"
    sha256 cellar: :any_skip_relocation, monterey:      "c8094fd45e0bfe752b4ba58b2ca73380a0c39bab39d9ad474caf7f75a8d5145b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8b4caf7913a724b8aaaaf992e7d47ba3fc9121ae4464fe2238b3b3c3addc18f"
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
