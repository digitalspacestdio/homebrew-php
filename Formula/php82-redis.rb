require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Redis < AbstractPhp82Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "12bc351832110a2a1c5ab43f49d81e105178c0314e6d84586dc150a24e462ad7"
    sha256 cellar: :any_skip_relocation, sonoma:        "ff67a420f72045f990fba5c7c022ac2eafa618c42d05517b9cd8dd5ca7333746"
    sha256 cellar: :any_skip_relocation, ventura:       "1442ffa5fed1b273e51c749a852ff9d0f83f6cc8bb71ae9b816b5566e01a746e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "112decd7d2dfb80b674a22bc1446a3abf28d035c53c3909fc35515f07229a9a8"
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
