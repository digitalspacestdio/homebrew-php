require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Redis < AbstractPhp80Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "86ea5778fbf0b2ee76bdf37df3ad4b5f3bea4a780592839b684b404b0fff0236"
    sha256 cellar: :any_skip_relocation, monterey:       "88aa1e2e62678446f819beafc51471089d1fc315a42453ddba843b1d37c17a82"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "55c86f5f53dcca0a7196d4999c8a5d1adeb8192476dbf4bf01a54fd5e3c920e3"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "4f4d41b347f741542dc97c07335b27892acca2db379647c1cd7e91e2cd4946ca"
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
