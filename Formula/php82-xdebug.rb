require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Xdebug < AbstractPhp82Extension
  init PHP_VERSION, false
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.2.2.tar.gz"
  sha256 "505b7b3bf5f47d1b72d18f064a8becb6854b8574195ca472e6f8da00bdc951a8"
  version "3.2.2"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "930a4044b66bd3be760ab80ac5154148bbca72544e7590f0db197fb69c748285"
    sha256 cellar: :any_skip_relocation, monterey:       "0cde81d8bd6d83abb45408696ebacf9ae87a3e09e079b10da60e72488f7e73a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d37f77f311e9e360141be93154b9243e44ca9e7a31b3390fe5f0ed5ff18b972a"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "f699eda181d2906c4dbbf24f37671a6bbd88011a9a8b3a83601be4f4718f6135"
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
