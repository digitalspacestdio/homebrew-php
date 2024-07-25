require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Apcu < AbstractPhp70Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.8.tar.gz"
  sha256 "09848619674a0871053cabba3907d2aade395772d54464d3aee45f519e217128"
  head "https://github.com/krakjoe/apcu.git"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.0.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a85c35c35ba956beef0a4cc040e389544d17efcf6763e529f437c77caf0489f8"
    sha256 cellar: :any_skip_relocation, monterey:       "11f0ccfd0dbaaf7b0f34581dbaf808085428235f8db10d2310b80ae400cdc25c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1119b5ac90e3e15136ec8416af15e4eeb450473170c4f3075ea1f34cdf61d3b0"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "fb9ed82284bf235599ecb8971f600e9865b1dca9362c4d2c2c750b6ee03cad58"
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
