require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Redis < AbstractPhp74Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "72ae3e4e91f625d4c6a7b1379d0570479748f2580d2d210248c719b1269234d8"
    sha256 cellar: :any_skip_relocation, monterey:       "fab128780a80b7f49d7e7b3b4d1caa9bdb96cf183ad180e9962134bc6127d194"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "92566a6ee0f2cb653407063f318c0f74d71bccfa8437856e7c804fd72c6218c8"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "67250007065f6930a569d11d4676c7c60afe8bb5601268e087b905a7d5c03a62"
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
