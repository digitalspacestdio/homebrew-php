require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Redis < AbstractPhp82Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b1b8c28ab5edc321517e9b4fbf8a1fce2d814e24f9e7a709469f25c9c943265b"
    sha256 cellar: :any_skip_relocation, sonoma:        "f6948a556739aa5c0470b7e0765a57725768a4f2d8da20aeba4df8f98d90be75"
    sha256 cellar: :any_skip_relocation, monterey:      "a7690aaed0efa70b2b9583048c0bafd9159d41af7c210bdee90485045a4e684e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4a79317bd202adc64acd9c98591f9262602617471e66a44fde2d8e3394e080a1"
  end

  depends_on "digitalspacestdio/php/php#{PHP_BRANCH_NUM}-igbinary"
  depends_on "igbinary" => :build

  def install
    args = []
    args << "--enable-redis-igbinary"

    safe_phpize

    # Install symlink to igbinary headers inside memcached build directory
    (Pathname.pwd/"ext").install_symlink Formula["igbinary"].opt_include/"php7" => "igbinary"

    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"

    prefix.install "modules/redis.so"

    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS

      ; phpredis can be used to store PHP sessions.
      ; To do this, uncomment and configure below
      ;session.save_handler = redis
      ;session.save_path = "tcp://host1:6379?weight=1, tcp://host2:6379?weight=2&timeout=2.5, tcp://host3:6379?weight=2"
    EOS
  end
end
