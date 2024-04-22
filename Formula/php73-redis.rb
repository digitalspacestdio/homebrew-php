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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "808c1dbb5bcb7f5b3c44d60d7bd641b560048a107da6af1e8ffe40488ee583e9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9052dbc46920c2d5d4db111c16c75df178608eb6dae359bce3822f768c6bce39"
    sha256 cellar: :any_skip_relocation, monterey:       "78c51686b7871465f0fe2c95d3a7ab73c9db81bb0b6ffb984931f6bc1cfc520e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "047361238b43078ae1de245c3969618aa163ead6eaa216958beced7d8936539c"
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
