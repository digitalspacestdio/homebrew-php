require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Redis < AbstractPhp73Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ad17c480f7302140ea10d93e642287e9e0e20aba3863bac5fe8921df67242b9d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7cfc9344044cc5a9354b1b2c153b1b814db63c1c86b27b06a92b4969c4a0e455"
    sha256 cellar: :any_skip_relocation, sonoma:        "389e0e719498800f81ddb43d19181605af8903b5ca8cfb917c26484af2b79618"
    sha256 cellar: :any_skip_relocation, monterey:      "628689cdaf6140fb10ffbc2a2d941a2fc7ee26769875f9053313577b3f194df5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c127f6770110d47ec927d410326673f4917f0e5033373722c557f8012a071ad0"
  end

  depends_on "digitalspacestdio/php/php73-igbinary"
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
