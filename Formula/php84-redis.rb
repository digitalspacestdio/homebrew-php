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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.1-106"
    sha256 cellar: :any_skip_relocation, ventura:       "0311787838185cdcbe268641a218942f296b3589bc5880d08892053dca0be9c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "834132d92cc8f1b6dd024a5e0b60f08dd16405de915836a31852c1433579a569"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "bf089f57f5e42405da8d7989a9d7de4128fabe79cc2347e5e5c1375b6b723a67"
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
