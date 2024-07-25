require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Apcu < AbstractPhp81Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.21.tar.gz"
  sha256 "6406376c069fd8e51cd470bbb38d809dee7affbea07949b2a973c62ec70bd502"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  version "5.1.21"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9d41470f92aa23fc1bdcc2daed78aebe5b30a84594102bc4388fdc30b8ddca2e"
    sha256 cellar: :any_skip_relocation, monterey:       "6e4c58475c4660544ec2ae132d61fb1ca7683d824a84c03057efa0d8b3ef2c1b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0b1ca0a30d8947ee6668832bd44d804a1d1a33835ddb4c66051b4181ad0c51bf"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "5b934906911a35cfe641624d16519f623cdabd32efc41fba442a160b6e3b7672"
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
