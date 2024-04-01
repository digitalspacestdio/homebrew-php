require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Redis < AbstractPhp71Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/5.3.7.tar.gz"
  sha256 "6f5cda93aac8c1c4bafa45255460292571fb2f029b0ac4a5a4dc66987a9529e6"
  head "https://github.com/phpredis/phpredis.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "283d89f438af8ce74ac5fc10b544dcd431d86273e22cb91175eff56333a3293f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "124f633e61889cbfd7d0c3ad4a80e0920609d3d078380b057dc69222b89a10db"
    sha256 cellar: :any_skip_relocation, sonoma:        "ac586342ed6df0d0d9ff0ab57066a885f216992ffe7fc823357050c786bcce09"
    sha256 cellar: :any_skip_relocation, monterey:      "42916a797206c373cd795bef310efa661130d83c4b51807f526cee13faf4ac96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "80182f5597679f7e60f07374d920c7f703a5eb21db50f1ef042862db09e39b49"
  end

  depends_on "digitalspacestdio/php/php71-igbinary"
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
