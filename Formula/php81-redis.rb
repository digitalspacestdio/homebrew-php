require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Redis < AbstractPhp81Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f636a3544fbf06a27eaa618633aa0f43fbd041190a77b5348e0342148fe7fd2c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f0fed8c129b575ac9dcc8b3db7da23fb9a595b2febad558b5b36e10f230aaeb1"
    sha256 cellar: :any_skip_relocation, sonoma:        "618083f5d8e3465c1d62052d176221e6f38e60a76c5e010e8e6fe5c5aa4235e7"
    sha256 cellar: :any_skip_relocation, monterey:      "adf242ec2b89bda55e592400160982e083c22af15602840672bcebfd204ac278"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a323bb62dc71a1faeb07a94f7e8d4703b554eb422670fd6518abc6321a85f80c"
  end

  depends_on "digitalspacestdio/php/php81-igbinary"
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
