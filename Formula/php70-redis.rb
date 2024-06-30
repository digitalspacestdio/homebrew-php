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
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.0.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c8d503328fda5411301d54596f61193a25537f688704f5acfc86b1e87d615bed"
    sha256 cellar: :any_skip_relocation, monterey:       "77a566b100d93a590e20a0e1e9e277903d71b8e84d784190f605986a3add5238"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b864e5b995cc5e49f15b1a5ac6e5a2d5c398e92463b5c9b7b470c88e5e25d73a"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "31178255d4e274fc28065f72c5c8c222e49692bfa7b61c0f3a8b1d49e8816819"
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
