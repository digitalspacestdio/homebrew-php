require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Redis < AbstractPhp83Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/6.0.2.tar.gz"
  sha256 "786944f1c7818cc7fd4289a0d0a42ea630a07ebfa6dfa9f70ba17323799fc430"
  head "https://github.com/phpredis/phpredis.git"
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e1bdfba5e176d3bad1b42dfb9567062f7f52193a6a3cc4705f86852df11bbf76"
    sha256 cellar: :any_skip_relocation, ventura:       "37e49c268e567fa59ef5e2693d28f106cd8621dd3ff95ff9b3e2a8c6bca7a730"
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
