require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Redis < AbstractPhp81Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c9957d61192c4d42c16acf17f5fee02cdb1b3fa545c4c81c165cd017e5b10d7f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0de3d664194a62e6b3c793a15d796fdc18d5e0dc4c89e3477f94cb0defc0082f"
    sha256 cellar: :any_skip_relocation, sonoma:        "3a5b2471728cf040b6ad79a3bb4d36f571e79e292fc6aa66a03e1633f5d139f3"
    sha256 cellar: :any_skip_relocation, ventura:       "777a56b27a235f39a80cfe15be66e75d2ac31bd84143e8bcf31a989f58788a4c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cff0da292090fbc55d59f43eec5ec9806f516df0040e546b7a605cedf73427cc"
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
