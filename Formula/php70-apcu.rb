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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, sonoma:       "26119db0b49e7207452a1033c6ba92234bd9f2383144cc418132a5d1f9ff302b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e3969e6ed16890fea71b1fc904f7da71d943305c0847cef4a83f47f39c8f3350"
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
