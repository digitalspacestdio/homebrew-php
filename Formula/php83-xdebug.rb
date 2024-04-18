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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d483c86d0c7ac027f3d5dcfd6e12f6e1b9a332aaf68693f3cfb33e9f527f0f5c"
    sha256 cellar: :any_skip_relocation, monterey:      "a957510a130311c1f64d48759c729ca9566f0f48fc0d466b7260607f55e39171"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "53c4086bac94cecf36c0263670900652ab6963ace1c0539e359df9677910df80"
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
