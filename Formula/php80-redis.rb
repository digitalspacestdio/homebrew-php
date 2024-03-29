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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9fbee210395e9cf2bd802049f737db7dbb9fa23b50e69d0c1f3b97a1ae14e024"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "77eaf9144d198fc7981dd747007be9560a49908439d8b511390a380b0e4d4156"
    sha256 cellar: :any_skip_relocation, sonoma:        "cbb5da6cb9bb84ebb16b108ba4003001799eddc5723f80c4c5d150869e925c45"
    sha256 cellar: :any_skip_relocation, ventura:       "8e4ea634be3871a808cf3dd473aed56274b51ab5d4d44d722608695e85d79285"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d691ffe623c53d057c9a9458eb6122635ebde2b8e3ba44ee84a78848e7d84de3"
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
