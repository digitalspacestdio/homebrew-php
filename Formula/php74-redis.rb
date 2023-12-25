require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Redis < AbstractPhp74Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "70d1b282e05fd6061145aed6caafa02a5626660126d35b6771c752badc75bffd"
    sha256 cellar: :any_skip_relocation, sonoma:        "0256063d3ab80fd4d432e6a4a3d6556240507a84353092cf1faae06273ef42af"
    sha256 cellar: :any_skip_relocation, ventura:       "be5771ad82b6a38a47920fa0c4360525bec80635b2243f42b5008833f1fd115e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "41425a87211dd254971a549c0b1d21a54a04b6d857916141d5dfc6e8e0212542"
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
