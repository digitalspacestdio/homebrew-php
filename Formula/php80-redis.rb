require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Redis < AbstractPhp80Extension
  init
  desc "PHP extension for Redis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "59e813b46d9845aab71893ae4fbd65b7a38b1cdba55b636c1d2f54bb393db7f9"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "582561a6a80c3847dc8a180fb8f448c91af62489f9d71336e6a0b7eb3c47ef12"
    sha256 cellar: :any_skip_relocation, sonoma:        "32ca8c7a75263d71bf4761d342870e3567ad09e2483a8825e83af7e2bb19a9ea"
    sha256 cellar: :any_skip_relocation, monterey:      "3710cf31360e8ab846dc50baa500f471dfc74680280c02f4a0d78d6ac7a93e8b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a0f2e069dbc0de1a61b2cbfaf7c177ca9561823487a05ef489dd1b6eb571740"
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
