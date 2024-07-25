require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Apcu < AbstractPhp74Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  #url "https://github.com/krakjoe/apcu/archive/v5.1.17.tar.gz"
  #sha256 "e6f6405ec47c2b466c968ee6bb15fc3abccb590b5fd40f579fceebeb15da6c4c"
  #head "https://github.com/krakjoe/apcu.git"
  url "https://codeload.github.com/krakjoe/apcu/tar.gz/1f98e34d936e1841e18fe5c25fdc64389456cdbc"
  sha256 "9f8ddc1232328108c29714fc7686db476dd630ffb94004f0fa055e1eae68dd26"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  version "1f98e34"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d2b4203751f46e91a782a512cf4c43f6550f8748a29174aaa3c0bb567e52bcaf"
    sha256 cellar: :any_skip_relocation, monterey:       "62df4ca0294d67719916a329f6d96fcf2d0c776f1e37f2b5677b362f46b7759f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9db557e3bd49381424578531c3672100e9a08df410929035a81e35a7769cfb83"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "b0dfefd2c43cbfdae62f3478ff16a46ebe9961ae2f8a9492439bc9c146e751cd"
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
