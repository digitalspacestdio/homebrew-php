require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Xdebug < AbstractPhp74Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.1.6.tar.gz"
  sha256 "217e05fbe43940fcbfe18e8f15e3e8ded7dd35926b0bee916782d0fffe8dcc53"
  version "3.1.6"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "efe73b70a763785a7ec70e4409689908268809740d035e070e604ce395c6c575"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2d7362a08c3b5f1b945042fab90b23783f9df83c5b2a1e5f69b8370627be275f"
    sha256 cellar: :any_skip_relocation, sonoma:        "acc699024071adcff38d8da81049223815548935fc5bdad15c29c92c63daaa58"
    sha256 cellar: :any_skip_relocation, monterey:      "b28c23c671c2dd17a65643d87e4bca51c295babf2c9267d337405fb25184d981"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "91f2de55b11536fafdbb86a2edc89caebe97b95e93b766610954fd9056207f8a"
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
