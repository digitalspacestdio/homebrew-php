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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0db2e7ea0a51556f1368c16f59aa418b43f067120f8d3a46695fb82000bca587"
    sha256 cellar: :any_skip_relocation, sonoma:        "0256063d3ab80fd4d432e6a4a3d6556240507a84353092cf1faae06273ef42af"
    sha256 cellar: :any_skip_relocation, ventura:       "be5771ad82b6a38a47920fa0c4360525bec80635b2243f42b5008833f1fd115e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a6587b8f602115c7da8b9f105ff854016e95ce4bd143d5138046488c5689915"
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
