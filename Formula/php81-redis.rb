require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Redis < AbstractPhp81Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "58a024a4385c043be3cf7b1217982f84d5a2383fde7a4cfec0550d00fb5a9b3a"
    sha256 cellar: :any_skip_relocation, ventura:       "777a56b27a235f39a80cfe15be66e75d2ac31bd84143e8bcf31a989f58788a4c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "05674ec25d246168880310471edfc6b4ae78199b9ad69fd40f449152d6e6bf46"
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
