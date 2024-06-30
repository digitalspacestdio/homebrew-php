require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Apcu < AbstractPhp72Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.8.tar.gz"
  sha256 "09848619674a0871053cabba3907d2aade395772d54464d3aee45f519e217128"
  head "https://github.com/krakjoe/apcu.git"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.2.34-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7b20bf72ce833724a16884d110e7918bc32e0a663726ca33afadc95f9d712fe6"
    sha256 cellar: :any_skip_relocation, monterey:       "49a9661c1a8daf4a33c7c132e192d3b202ffb7e4068a791661567cc1d187c0d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c08adb255fc5f7b7d67adf263b3a9d88653eef1a4554c642bdaa2d1314b14b41"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "3277be6b361007e18514cb8f1cff738b3ea2f4a43fd52ed762cc599358f57ee9"
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
