require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Xdebug < AbstractPhp81Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.2.2.tar.gz"
  sha256 "505b7b3bf5f47d1b72d18f064a8becb6854b8574195ca472e6f8da00bdc951a8"
  version "3.2.2"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "17384a80836ffc776545f9b0d35c95f2ea6115df3caa1d8ccc9dad68b244e176"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "53e95cbee9ac29f2d1d45d0d014b09e67b8eb839ce4a0e40142aa4fd9c0e5e67"
    sha256 cellar: :any_skip_relocation, sonoma:        "09014fa57eecb5e106a11d93ff96edd43612dd2f16abe7ccfb506ce1ea414300"
    sha256 cellar: :any_skip_relocation, monterey:      "1e2e9131fd9aa2837bf09355a151f6cae80a8ebd9086def9c60e0c1513bdb672"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "944b1bdcb166455ac77ccba19d357593317d997a662e3829f6d198db7b41c7e6"
  end

  def extension_type
    "zend_extension"
  end

  def config_file
    <<~EOS
      [#{extension}]
      #{extension_type}="#{module_path}"
      xdebug.mode=off
      xdebug.start_with_request=trigger
      xdebug.client_host=127.0.0.1
      xdebug.client_port=9003
      xdebug.discover_client_host=false
      xdebug.remote_cookie_expire_time = 3600
      xdebug.idekey=PHPSTORM
      xdebug.max_nesting_level=512
    EOS
  rescue StandardError
    nil
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make clean"
    system "make"
    prefix.install "modules/xdebug.so"
  end

  def post_install
    write_config_file
  end
end
