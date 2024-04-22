require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Redis < AbstractPhp56Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.4.tar.gz"
  sha256 "656cab2eb93bd30f30701c1280707c60e5736c5420212d5d547ebe0d3f4baf71"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION
  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a25de6df7880b9acd6bd3b81ea6f147fd2d009b460f48a1845d6781af65b4624"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1fb8640736d7361826e0fbfbf8adeb5f36826fb7b9349c2c7a080f306f9c9236"
    sha256 cellar: :any_skip_relocation, sonoma:         "0d6ecd52d970b0d754fd5b6db7e46155b6b1df59dbfe42a3cb45c9f56a508e93"
    sha256 cellar: :any_skip_relocation, monterey:       "5ea845e12ae1d77e1ed3d9b16a89e776778ea5ca39e94315b51def1836ed4c12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "748f7c7cc36cb7b7d59b7fc9fff7367a4cff4cb9dd957b4f6f44399e7d33eb52"
  end


  depends_on "digitalspacestdio/php/php56-igbinary"
  depends_on "igbinary" => :build

  def install
    args = []
    args << "--enable-redis-igbinary"

    safe_phpize

    # Install symlink to igbinary headers inside memcached build directory
    (Pathname.pwd/"ext").install_symlink Formula["igbinary"].opt_include/"php5" => "igbinary"

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
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
