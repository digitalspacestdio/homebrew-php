require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Redis < AbstractPhp83Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/6.0.2.tar.gz"
  sha256 "786944f1c7818cc7fd4289a0d0a42ea630a07ebfa6dfa9f70ba17323799fc430"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "eeee6a3316d4405c8e2809480897e5e4d412b308229b1bc9f0fa5e30824cca63"
    sha256 cellar: :any_skip_relocation, monterey:       "639a4bf94b7048b1e8c2c41a6a34270ffea0f1e8c01a7478478c07337b3c861b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eada276a8ba22dc2f010ab637dd488b9074bb2030e185e51e11dd21895a88060"
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
