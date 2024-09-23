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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0beta5-100"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "76b2fe8f7366f60dd5eb653ac74d93bf8080263a299ff232230b10ab6fc8e6bc"
    sha256 cellar: :any_skip_relocation, ventura:        "01d8ce37aee3656a052badb65c1608f00ec47786276ea02ec6a47f37aa871b4e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "38225f3403cef20a7c6fd7058ee8077419e1bd7250b35ff8e9f10d9354e31d92"
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
