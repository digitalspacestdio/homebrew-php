require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Redis < AbstractPhp56Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.4.tar.gz"
  sha256 "656cab2eb93bd30f30701c1280707c60e5736c5420212d5d547ebe0d3f4baf71"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION
  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "e6ffacb695d13b0da2a4da544f0ab3841986ba959aef5318edcaf31765a87188"
    sha256 cellar: :any_skip_relocation, sonoma:       "2ca925f9c477cb82567793955696d50cbc860c8e8164fb140bb6e28641fae619"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2e99f97667becbb4eb538e9d547bffc8a80bebc68348a1ba29bad2953de08da6"
  end


  depends_on "digitalspacestdio/php/php56-igbinary"
  depends_on "igbinary" => :build

  def install
    args = []
    args << "--enable-redis-igbinary"

    safe_phpize

    # Install symlink to igbinary headers inside memcached build directory
    (Pathname.pwd/"ext").install_symlink Formula["igbinary"].opt_include/"php5" => "igbinary"

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
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
