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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a59273bf2cbb78127ba825b4faa98c3d5247b8aadedd876ea5693e63f673a5b9"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cf5a7d1ae6a9ed45881930df81f5fc52e5be9ebab69d54e8044d7bb380dae99a"
    sha256 cellar: :any_skip_relocation, sonoma:        "9d9a066d47e2a165f4491f0ae5c77912db96950a229a849a42671ca073fc6fd2"
    sha256 cellar: :any_skip_relocation, ventura:       "90343c3f829125d59f547fa19507fdac720a3aba9d038328de66cf1375638531"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef32b8306b2aa09b9fef8fbac5411e13919002f3f08f81b799071b1d4658baef"
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
