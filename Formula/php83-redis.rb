require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Redis < AbstractPhp83Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/6.0.2.tar.gz"
  sha256 "786944f1c7818cc7fd4289a0d0a42ea630a07ebfa6dfa9f70ba17323799fc430"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.9-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "814c2b151d065522901016d81b966b22038c8358904f6fe81b74d7a34a6728ec"
    sha256 cellar: :any_skip_relocation, monterey:       "2bf06b144268e663871cae3c14b4bbd54573ab708fdee499cddc4e5879b58ba4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fa929018c03c03f26add4237ea4da450305308188ea27c2b39e51e0f4cf2c50a"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "5fc354918fd40abff3bef5f48fa7172bb8813a293a4aaf233fcae645be75e9ea"
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
