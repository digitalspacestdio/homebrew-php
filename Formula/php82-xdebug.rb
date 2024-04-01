require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Xdebug < AbstractPhp82Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.2.2.tar.gz"
  sha256 "505b7b3bf5f47d1b72d18f064a8becb6854b8574195ca472e6f8da00bdc951a8"
  version "3.2.2"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c08bc503787e493cff9d601d2b7cec983f335b112529614e0497976bf09c1dfa"
    sha256 cellar: :any_skip_relocation, sonoma:        "53f993b6bee9de2cbbdafadc509b2f317e16b6d3b261a772e52060054ce72213"
    sha256 cellar: :any_skip_relocation, monterey:      "4b2264b9494b5f7a25cb83f29e7f46f5e63d94b3d3f4d2a40e6d89380653d651"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d367c82a226eb27f4724c4fffab4ccabd062db0e0b2f83be6cf2f1baf060a45c"
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
