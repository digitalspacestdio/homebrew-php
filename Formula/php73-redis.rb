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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a21e45af75446f08d3add9fb0e6ca9b3954a5112e487ba8fec65ffdf342bc862"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ce130066c6ef9391ada145123bf1c5a0c933e24c0d2a3616d481c03ab74f3395"
    sha256 cellar: :any_skip_relocation, sonoma:        "f2d2e4ad743a23653508e68502992386c7c622dc03f37afba1ee9fe46747e820"
    sha256 cellar: :any_skip_relocation, monterey:      "628689cdaf6140fb10ffbc2a2d941a2fc7ee26769875f9053313577b3f194df5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e39b4f201f5346192922c311d9fceba408ec08af6e69c4e47275ed0644c8ba41"
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
