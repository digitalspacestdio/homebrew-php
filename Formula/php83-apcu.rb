require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Apcu < AbstractPhp83Extension
  init
  desc "APC User Cache"
  homepage "https://github.com/krakjoe/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.23.tar.gz"
  sha256 "1adcb23bb04d631ee410529a40050cdd22afa9afb21063aa38f7b423f8a8335b"
  url "https://github.com/krakjoe/apcu/archive/v5.1.23.tar.gz"
  sha256 "1adcb23bb04d631ee410529a40050cdd22afa9afb21063aa38f7b423f8a8335b"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.8-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1dda3033db7f8334e6edf87a54c0967b2ff7b0fad59e626fae251b6aeefba148"
    sha256 cellar: :any_skip_relocation, monterey:       "09d794456a07105b6638ca344c4b9b1fc9e2ba65f5c51d8e4385e8597ecc80fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3760f242a16967b385c6cd51e0ab1240f9ceddd57f264c2feb1d69237edcc6db"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "feb4769910443e2171b1c3dcdd0c6391823f9b8859df8d7e7d3b9de4a76b799d"
  end

  depends_on "pcre2"

  def install

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    args = []
    args << "--enable-apcu"

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/apcu.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
      apc.enabled=1
      apc.shm_size=64M
      apc.ttl=7200
      apc.mmap_file_mask=/tmp/apc.XXXXXX
      apc.enable_cli=1
    EOS
  end
end
