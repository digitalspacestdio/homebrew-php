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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "12ddf290092b04c2ffa0080c81d6ae6fd32c50766958385dc39a10a777e0dcbe"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e514c279a3b757da661ea789f05fdd0fdd3d0933db260ec8fd568d622ba0cf84"
    sha256 cellar: :any_skip_relocation, sonoma:        "cc11c9e0eb35ef717185ad138192e74fcaf935af7560c1e65df8b016f08a1e2b"
    sha256 cellar: :any_skip_relocation, monterey:      "8177a4f5858a6ba7ef1ebba782d0456d404405fbcaf7a3598c4d4e6abe75f62c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "47c12b37e2b52ea24b62e978b2ee7fd8e70e89ef6c788204cfa76c65a485a026"
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
