require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Redis < AbstractPhp81Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/6.0.2.tar.gz"
  sha256 "786944f1c7818cc7fd4289a0d0a42ea630a07ebfa6dfa9f70ba17323799fc430"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "98bdd1e691e1ae6c27dc24c59fdb26fbe766d35459f34713c97b9d57a5640409"
    sha256 cellar: :any_skip_relocation, ventura:       "d1b58535acd2c5c32a6e6fc1a07d67066f7cacc5b39026c93f2535fef4d2f677"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6be55db74d54ac85bbd3bc55b1f0e58758f327aa117b6d31af320b1970573d51"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "eb5bf99408ca71febbbc86ffbfa9d80eda3af94b8a11dd883f0f00c12d1368f5"
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
