require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php85Redis < AbstractPhp85Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/6.3.0.tar.gz"
  sha256 "cb8f81df1a275599e4f8ddcfec7e1f65ed1953e6f5673649149fd680ebff4cad"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  version "6.3.0"
  revision PHP_REVISION

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
