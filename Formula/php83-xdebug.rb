require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Xdebug < AbstractPhp83Extension
  init PHP_VERSION, false
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  #url "https://github.com/xdebug/xdebug/archive/master.tar.gz"
  #sha256 "b3afd650918ec5faaae0bf4b68cd9cd623d6477262792b2ac8f100aafa82d2f8"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.3.1.tar.gz"
  sha256 "76d0467154d7f2714a07f88c7c17658e24dd58fb919a9aa08ab4bc23dccce76d"
  head "https://github.com/xdebug/xdebug.git"
  version "3.3.1"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.14-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "645fe03a6b58e3d9aa609fa813f8cb38dd463f16d24ca9a7c43ecda3bc583fbb"
    sha256 cellar: :any_skip_relocation, ventura:       "0921762125ab1090d42088dac3cce523570b8a9e6ee000249943a5857aa00b01"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "34b2d8b7fc18f838e07cc5b09d2d204211928e5fc3dcce8a581d54872972bb1a"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "e6262e9e27ef20eab9d6ffe8f65d6a9c5748c5971a54969b437e70bc040211fb"
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
