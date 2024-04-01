require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Redis < AbstractPhp82Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f2ab00b23b46962487ff382605447ae75a8263b1390fb0c4edc02bb61806d8b5"
    sha256 cellar: :any_skip_relocation, sonoma:        "739fc81480ff13d0f6bbdcae8e6427a1bdf8f8c097d1ab234cb8feb6d73ed207"
    sha256 cellar: :any_skip_relocation, monterey:      "f0ef056bb33a5c046c9a188435c967955170787a3c3173bc2a5fe31c0cbf74df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4a79317bd202adc64acd9c98591f9262602617471e66a44fde2d8e3394e080a1"
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
