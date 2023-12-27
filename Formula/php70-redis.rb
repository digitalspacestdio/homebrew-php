require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Redis < AbstractPhp70Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "986abd59ce49c78f3218a6b7ab16d9b8101280e830b96659077b96cc324fd972"
    sha256 cellar: :any_skip_relocation, sonoma:        "50c6f2bd3012f7f59663d5ccb6bfcb5b6d8be9086cdf25bc13d9744659cac279"
    sha256 cellar: :any_skip_relocation, ventura:       "9775fde715d5f35451c60b3bbc0e51e9d92cc1690f5e0a4003816114f675e6de"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f9a692e8f9b23581dea3ce188ca4feddbf536d8320a5fc2a90217ae9b80f9e07"
  end


  depends_on "digitalspacestdio/php/php70-igbinary"
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
