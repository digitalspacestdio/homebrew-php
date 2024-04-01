require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Redis < AbstractPhp56Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.4.tar.gz"
  sha256 "656cab2eb93bd30f30701c1280707c60e5736c5420212d5d547ebe0d3f4baf71"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION
  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "55440a01a01b66b7b206aa5b38dc01b173bbde079b7b7cfceb14d14645f335e7"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cee3d6d0b8cb86ba35dc1f298ad303696c9a79d470d0720781defc964101762c"
    sha256 cellar: :any_skip_relocation, sonoma:        "6147a3eae1ed410f339bbd339993c080af1fec043b213db5f81f4c43d00a23b3"
    sha256 cellar: :any_skip_relocation, monterey:      "fcafc88ae58f499943a7392a511f22aaea39f0759c6af128679d335b74ecc42a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "346dbb4428914472e038e69690f6f99fcb1a79f714ce7ac1fc5d43b98395e56c"
  end


  depends_on "digitalspacestdio/php/php56-igbinary"
  depends_on "igbinary" => :build

  def install
    args = []
    args << "--enable-redis-igbinary"

    safe_phpize

    # Install symlink to igbinary headers inside memcached build directory
    (Pathname.pwd/"ext").install_symlink Formula["igbinary"].opt_include/"php5" => "igbinary"

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
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
