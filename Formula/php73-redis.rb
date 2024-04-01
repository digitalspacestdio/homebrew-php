require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Redis < AbstractPhp73Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a21e45af75446f08d3add9fb0e6ca9b3954a5112e487ba8fec65ffdf342bc862"
    sha256 cellar: :any_skip_relocation, sonoma:       "1144feefb2f5d2feb0099aa90c7ed53e9197a06d20b7ca2707faad79e4d7bc9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fb3c1a4aaa46185166c9aedaf454e835152d7eeb5b788af8ffc54dd49a0de957"
  end

  depends_on "digitalspacestdio/php/php73-igbinary"
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
