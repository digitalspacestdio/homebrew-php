require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Redis < AbstractPhp81Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/6.0.2.tar.gz"
  sha256 "786944f1c7818cc7fd4289a0d0a42ea630a07ebfa6dfa9f70ba17323799fc430"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5dd1eccf629caffeb4e15a5939952fdfdc35887f0c4859f3e4aa95d6c293fa1f"
    sha256 cellar: :any_skip_relocation, monterey:       "fb797dc66028e0a24bacf83d28691909271eaa1545100756d9c3a31defc05790"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8dc9662977cd2d27e603d70ecf99638505a90bcc6acee17a2b4c886142e5a735"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "917acc22f7764a8ca13ec8228b88467792f3962ad1b8f8196dbfa25cf0f721ab"
  end

  depends_on "digitalspacestdio/php/php81-igbinary"
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
