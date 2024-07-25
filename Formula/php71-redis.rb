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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "abc2cc2cc4909d58992669d4eebdcdf9a81ce8c6cf7edc1af4e17b0a78b7a08f"
    sha256 cellar: :any_skip_relocation, monterey:       "44452e61bc331d1ec8d51bc133999e9321372b5724f2f2df1d80f7712c3f015e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "28a14b242c4deca7289a7ea10ab48594cec52836546bbc9608f5a3f985b241d3"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "72125f790b05043d4869a3c0afe6cb9f7322248af39d2c29d3e458bc3d4bbf1d"
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
