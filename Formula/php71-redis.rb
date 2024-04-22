require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Redis < AbstractPhp71Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "89db490f637a898c94ebd6802ef12cb2ae3957e43669592847bab3657c41b70c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9d6c4858a552d1ed1510529ef6f8b2f7256f41f545b1bfdc98b502fb820b8fa2"
    sha256 cellar: :any_skip_relocation, monterey:       "6b457b2a62f3b3e05330519eacff53600bd6b60e4d771378619ffe5b81b3d719"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "918a1b35c79c2daaa4c4c260b0b061f06cd71da44e454b0b06d95191c8ea2322"
  end

  depends_on "digitalspacestdio/php/php71-igbinary"
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
