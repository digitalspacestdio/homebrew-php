require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Apcu < AbstractPhp70Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.8.tar.gz"
  sha256 "09848619674a0871053cabba3907d2aade395772d54464d3aee45f519e217128"
  head "https://github.com/krakjoe/apcu.git"
  revision 2

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "942aacb1e58d854a49cfa3e38cbcd8c371ca5a5becfe9d0212a0485a8234daa5"
    sha256 cellar: :any_skip_relocation, ventura:       "b3ce533f9902dff46fdc6a93206c3f7e1f1c211fb1222da0c16e18f8cf00175e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "20cf152efc8c3187821b504c4417445e874dcb2ae6d2aa4106769ab16897a134"
  end

  depends_on "pcre"

  def install
    # ENV.universal_binary if build.universal?

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
