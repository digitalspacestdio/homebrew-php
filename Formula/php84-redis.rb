require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Redis < AbstractPhp84Extension
  init
  desc "PHP extension for Redis"
  url "https://codeload.github.com/phpredis/phpredis/tar.gz/6ea5b3e08bdbf8cbe93e0dc56b18e8316d65097c"
  sha256 "1ead0114e39dec20f0ce254a5aaf10eb9a4e69abbaa398ad539a1c6597e3abf9"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  version "0.0.0-dev.1"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0-100"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9684cd83e6887b4d0bfe4e93819a1e4d746ab01471edf4ee4e0870546c28c00c"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "ea056ad6efeb36ae407241a7fb090f2543a9ed347332e5ae3afb541608220c17"
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
