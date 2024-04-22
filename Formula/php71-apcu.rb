require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Apcu < AbstractPhp71Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.8.tar.gz"
  sha256 "09848619674a0871053cabba3907d2aade395772d54464d3aee45f519e217128"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "57387a80f58c92cf4701000c853165845f2e38da4cb2690d064dc9fe84e92bac"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0a9324e1558f097ac95c963097830cec81e8bde476973c47d8836523648729f2"
    sha256 cellar: :any_skip_relocation, monterey:       "a3f7fcc8948f082d0af679773145b3f5b5cf9962cdd4521c0971b1bd35b7eb80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1d8d8c202eb2294630d81f14d918e22b5d48d51589245b555bd13e2d92d7baba"
  end
  depends_on "pcre2"
  revision PHP_REVISION

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
