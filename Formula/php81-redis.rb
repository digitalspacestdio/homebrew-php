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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7aeb1e71449fd22db4c7dea66dafaca614d0b2fdd1dedf7ae0a9d592298b1bd3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f552fdffe5bc3ec7d8e06fdbab32741e323171f0f355f1e8083f0d54bf494199"
    sha256 cellar: :any_skip_relocation, sonoma:        "08867b3f08efb89e6d77933604eab3645259a314ef8408cf8c7d1a39dfb1d198"
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
