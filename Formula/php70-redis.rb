require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Redis < AbstractPhp70Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "54df01faba6be09b9b415ae36ae94e433d1ec4f055129249578820db26f83f64"
    sha256 cellar: :any_skip_relocation, sonoma:       "3f49da490f40b25f5c84f8da0e110dcb1b9b0e32d9078a1e71b7e16038301e8f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "763195ce8edfd6ebcd5672552b8c0ffa972f2bb50efc654acf695db9f75defe4"
  end


  depends_on "digitalspacestdio/php/php70-igbinary"
  depends_on "igbinary"

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
