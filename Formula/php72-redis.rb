require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Redis < AbstractPhp72Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.2.34-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c0c71a2ce23308dc5fb2a22e1e8be9373afc3d111e45caac46135d53c6932054"
    sha256 cellar: :any_skip_relocation, monterey:       "8c46005cfd1c46b7346872d77c1e308700cbce2b5c368ef186229f46992f0f0c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b9b8bd3da541a5b61deccdb63a397d9471f43c7bd02f845a8e7f641712556de4"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "277a129cdb5f0f2915184a09a65d84a691f9f845d855eac84678904a8dff7f1d"
  end

  depends_on "digitalspacestdio/php/php72-igbinary"
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
