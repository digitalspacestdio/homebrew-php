require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Apcu < AbstractPhp56Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://pecl.php.net/get/apcu-4.0.11.tgz"
  sha256 "454f302ec13a6047ca4c39e081217ce5a61bbea815aec9c1091fb849e70b4d00"
  head "https://github.com/krakjoe/apcu.git"
  revision PHP_REVISION
  
  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a337b24da6e44601e6f3aa475501be258c25e086b4bcd35abd36477e77315120"
    sha256 cellar: :any_skip_relocation, sonoma:       "3c1114eee264e0176ec7620a1dd15d5239ac1c7ccf74a93c8d1b4317f954a906"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6211425e43bf146f37f9d070ca7f439431830d92fb88579823388e51357c8d9c"
  end


  option "with-apc-bc", "Whether APCu should provide APC full compatibility support"
  depends_on "pcre2"

  def install
    Dir.chdir "apcu-#{version}" unless build.head?

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    args = []
    args << "--enable-apcu"
    args << "--enable-apc-bc" if build.with? "apc-bc"

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
