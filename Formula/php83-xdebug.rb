require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Xdebug < AbstractPhp83Extension
  init
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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "606ea303d3d5e27ddec10e9ffc2c24e8f1c5805a9a0a490c2652ec3ae3902bd2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b79126a6e09a60b4410715b882be4c1a60b18710f5e0efa4d835cccdf165817b"
    sha256 cellar: :any_skip_relocation, sonoma:        "cbea371918f2595d618652b9efdece9077968131fe04095fcd5d55784b32ac83"
    sha256 cellar: :any_skip_relocation, monterey:      "b17dee019007d30fbb0e132e757f0c9bf84211534aed3eca89933eea38dcda62"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "243ac91925726127df4bb4306452ae81ca5cdc808f93cdf6d2613dd28ab0f343"
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
