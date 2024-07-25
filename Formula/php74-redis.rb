require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Redis < AbstractPhp74Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b57e759a56ec5543578d384138bb8d849317ad65c84164359a486d6f091c4195"
    sha256 cellar: :any_skip_relocation, monterey:       "15abbe59b591cb0d47bf68c6ee279b778daccf26afb47cc08ee5dad86ebad2aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fb4adb1a8b45c0fa60f3a881ea9169442e472d0e9aeb7bbefdf89b2a3bd42177"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "f080ae85829cd2829a890a35daa3c6faff223992307d669ceefe1d2758be7a22"
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
