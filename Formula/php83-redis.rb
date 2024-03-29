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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3a1f2d2a24117c960ac7b328f50beb0db5f52652e64de578188d7b7f6eb2e2e2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ca8a75ffaee021ec749cea5372e78462c10e7571a20b3100488a2ae3d2ce4460"
    sha256 cellar: :any_skip_relocation, sonoma:        "9ac7f29f2e40a951875ecaf1048628543b8461cc440e2e2203d1af79f10e336d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f5ad2a54ea8212f9e69d42145251ac01c8a0c54bd3065b8bb320e69c2a65a19c"
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
