require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Redis < AbstractPhp80Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6f1741962afa83681b7bde85d6f13a6ee918559614604717a5de6181bbd7f98d"
    sha256 cellar: :any_skip_relocation, monterey:      "2a170572c93be0574466e9774f5f33d245d2ca60d1001f108eb79e6d8b69bee6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "40dbac02f0ccad9e85d951ea0671414e2c065af74710964ee7e72a28a2ef9557"
  end

  depends_on "digitalspacestdio/php/php80-igbinary"
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
