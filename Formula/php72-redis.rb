require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Redis < AbstractPhp72Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d39922aedabb3f1314cd29d31c6bd975783475207bdb1910df04f40c8634f602"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7551c6e81e468cfdb01946a6202b08bb18ca565d4d4f87bbff39e46f542f43b2"
    sha256 cellar: :any_skip_relocation, sonoma:        "0978af278b3197c6a55586d790e4d9bffb3d9354c194cdee532ab6cc1e2963f4"
    sha256 cellar: :any_skip_relocation, monterey:      "4b1350eccf5a8b500229794bb841806877651990e1fd262f36392ae1152c4525"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "223ca82b186f5f1fac3be7ded75af4ae51523327f26e307c6c8586ed900eb94f"
  end

  depends_on "digitalspacestdio/php/php72-igbinary"
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
