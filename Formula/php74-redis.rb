require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Redis < AbstractPhp74Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.4.33-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8ccab051189e7fe98073d779defc9fcdba9c9f8250ed1e9d86a8cd028a87ef19"
    sha256 cellar: :any_skip_relocation, monterey:       "91b0e95c14eaf0c50421f340d80a4345c8d638b32c3c31b43f5c9dc05377ceda"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "848dfa547b8e36ba3e13d29f02fa775c2996b158203e5be330dabbfe3b24b168"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "5ab27e537b3fadbe0b0fb774202355c592cf31684ecf15f97e269f3d51bceb01"
  end

  depends_on "digitalspacestdio/php/php74-igbinary"
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
