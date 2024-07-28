require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Redis < AbstractPhp82Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/6.0.2.tar.gz"
  sha256 "786944f1c7818cc7fd4289a0d0a42ea630a07ebfa6dfa9f70ba17323799fc430"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9543684448511e0425714413140fdf8f65e51603455150a5cc0d52a5b292bc01"
    sha256 cellar: :any_skip_relocation, monterey:       "1bfe613614a76f4dd8c518bb3c956bfb882a1e421d4277371fa9f446b6f9ad63"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a5c07d9015f14f8c7cedf73799d6a4ee4077878c3aa5a0bd60793c964b5bace3"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "e3c302a4710faed08ea503a9288e0fbbbcbe2df49539ab03db6db08cb6f9e565"
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
