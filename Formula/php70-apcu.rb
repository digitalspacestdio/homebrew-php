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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ae519604379ff074c915b52cc578ae09319d5266a4f7c3df2192e04ff6f99f03"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4b9bf2844d085e026a0a0adcb2fb70cb69478426280fab47e65a2011542b53f7"
    sha256 cellar: :any_skip_relocation, sonoma:        "858405b8ffd3fa34051e8a9c9fe4dc5144008297888a7ced8245582f6b98c845"
    sha256 cellar: :any_skip_relocation, ventura:       "b3ce533f9902dff46fdc6a93206c3f7e1f1c211fb1222da0c16e18f8cf00175e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0903132cff1ed41e7778e757ac47a67c3bd9aba040dc0eaf49a810775ec44fd5"
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
