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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1af9faf687422985df0216f5d6018a1271bc28dd7eb47e93360ef76c3f72dcb9"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5249315467359b361e6c20173a03f9a8804cf0afcae7157dd8994a91cfb68d69"
    sha256 cellar: :any_skip_relocation, sonoma:        "acb08b3c1888ef31c9a1d6a48cbc46d4bc16d7267a93eab8bfa3f031a36f338b"
    sha256 cellar: :any_skip_relocation, monterey:      "e93ea454ca213d641ff102ad46c5f537a7b6fe3e7eef9f2471c9bbb80b30c71c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "07ec9a319a0156789b0849b1086a6d73226df16667ceebb1ca66db8768743b9a"
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
