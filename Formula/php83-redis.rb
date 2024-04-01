require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Redis < AbstractPhp83Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/6.0.2.tar.gz"
  sha256 "786944f1c7818cc7fd4289a0d0a42ea630a07ebfa6dfa9f70ba17323799fc430"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4b1ecccc0a43312c67d2b77be690fa475dae3dac3312c358aee29ad5f0d9ea7c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d54880d95a751827c83eef9d1d26fde2926de042b13c457d57748efeed89e62e"
    sha256 cellar: :any_skip_relocation, sonoma:        "914ea3f68cf4d040bc2abfff101bf63eb5bac0b204fedf810ced6c5de662096f"
    sha256 cellar: :any_skip_relocation, monterey:      "428b191dc4f2a8fe6331a4c4cc8cbcce111483a45eed8e83cfd655585c58bfc4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0c9a9a8c3d28ca88322beee62e273f113091d303b74ce8705667a71bc69746cd"
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
