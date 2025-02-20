require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Redis < AbstractPhp84Extension
  init
  desc "PHP extension for Redis"
  url "https://codeload.github.com/phpredis/phpredis/tar.gz/5419cc9c60d1ee04163b4d5323dd0fb02fb4f8bb"
  sha256 "58a1d293ec3a7214813da32545272acfef9346720ddecfa014f9d1c85e8471e7"
  head "https://github.com/phpredis/phpredis.git", branch: "6.1.0"
  version "6.1.0"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.4-111"
    sha256 cellar: :any_skip_relocation, ventura:      "c992a3667b935cc3df0fdfecbb1200d7bc4166abdac5bad53765eed0c2d08db2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1817008afdcbf6f2922af36b93a90bfc2bddd3ddd14a0086244132db8d15c2c8"
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
